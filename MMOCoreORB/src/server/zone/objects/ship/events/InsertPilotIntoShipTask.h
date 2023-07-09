/*
 * InsertPilotIntoShipTask.h
 */

#ifndef INSERTPILOTINTOSHIPTASK_H_
#define INSERTPILOTINTOSHIPTASK_H_

#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/SpaceZone.h"
#include "server/zone/objects/ship/PobShipObject.h"

class InsertPilotIntoShipTask : public Task, public Logger {
	ManagedWeakReference<CreatureObject*> play;
	ManagedWeakReference<ShipObject*> shipObject;

public:
	InsertPilotIntoShipTask(CreatureObject* creo, ShipObject* shipObj) : play(creo), shipObject(shipObj) {
		setLoggingName("InsertPlayerToShipTask");
	}

	void run() {
		ManagedReference<CreatureObject*> player = play.get();
		ManagedReference<ShipObject*> ship = shipObject.get();

		if (player == nullptr || ship == nullptr)
			return;

		auto spaceZone = ship->getSpaceZone();

		if (spaceZone == nullptr) {
			return;
		}

		Locker lock(ship);

		Locker clock(player, ship);

		if (ship->isPobShipObject()) {
			auto pilotChair = ship->getPilotChair().get();

			if (pilotChair == nullptr) {
				return;
			}

			// Always apply the interior state
			player->setState(CreatureState::SHIPINTERIOR);
			player->setState(CreatureState::PILOTINGPOBSHIP);

			player->switchZone(spaceZone->getZoneName(), pilotChair->getPositionX(), pilotChair->getPositionZ(), pilotChair->getPositionY() - 2.f, pilotChair->getObjectID());
		} else {
			player->setState(CreatureState::PILOTINGSHIP);
			player->switchZone(spaceZone->getZoneName(), ship->getPositionX(), ship->getPositionZ(), ship->getPositionY(), ship->getObjectID());
		}

		if (player->isGrouped()) {
			auto group = player->getGroup();

			if (group == nullptr)
				return;

			Locker glocker(group, ship);

			group->updateMemberShip(player, ship);
		}
	}
};

#endif /* INSERTPILOTINTOSHIPTASK_H_ */
