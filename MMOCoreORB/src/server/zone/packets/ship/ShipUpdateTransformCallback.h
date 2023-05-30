/*
 * ShipUpdateTransformCallback.h
 *
 *  Created on: 01/09/2011
 *      Author: TheAnswer
 */

#ifndef SHIPUPDATETRANSFORMCALLBACK_H_
#define SHIPUPDATETRANSFORMCALLBACK_H_

//#define SHIP_TRANSFORM_DEBUG

#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/managers/collision/CollisionManager.h"
#include "server/zone/packets/MessageCallback.h"
#include "server/zone/packets/object/PlayClientEffectObjectMessage.h"
#include "server/zone/packets/ship/ShipUpdateTransformCollisionMessage.h"
#include "server/zone/packets/ship/ShipUpdateTransformMessage.h"
#include "server/zone/packets/ship/PackedVelocity.h"
#include "server/zone/packets/ship/PackedRotationRate.h"

#ifdef SHIP_TRANSFORM_DEBUG
#include "server/zone/packets/ui/CreateClientPathMessage.h"
#include "server/zone/packets/object/ShowFlyText.h"
#endif // SHIP_TRANSFORM_DEBUG

class ShipUpdateTransformCallback : public MessageCallback {
private:
	const static bool errorLog = false;

#ifdef SHIP_TRANSFORM_DEBUG
	const static bool sendText = true;
	const static bool sendPath = true;
	const static bool drawPathRadius = false;
#endif // SHIP_TRANSFORM_DEBUG

protected:
	const static constexpr float positionMod = 1.5f;
	const static constexpr float positionScale = 8000.f / 32768.f;
	const static constexpr float directionScale = 1.f / 127.f;

	uint16 shipId;

	int8 dirX;
	int8 dirY;
	int8 dirZ;
	int8 dirW;

	int16 posX;
	int16 posZ;
	int16 posY;

	PackedVelocity velocity;
	PackedRotationRate yawRate;
	PackedRotationRate pitchRate;
	PackedRotationRate rollRate;

	uint32 counter;

	float positionX;
	float positionY;
	float positionZ;

	float directionX;
	float directionY;
	float directionZ;
	float directionW;

	long deltaTime;

public:
	ShipUpdateTransformCallback(ZoneClientSession* client, ZoneProcessServer* server) : MessageCallback(client, server) {
		shipId = 0;

		dirX = 0;
		dirY = 0;
		dirZ = 0;
		dirW = 0;

		posX = 0;
		posZ = 0;
		posY = 0;

		counter = 0;

		positionX = 0;
		positionZ = 0;
		positionY = 0;

		directionX = 0;
		directionY = 0;
		directionZ = 0;
		directionW = 0;

		deltaTime= 0;
	}

	void parse(Message* message) {
		shipId = message->parseShort();

		dirW = message->parseSignedByte();
		dirX = message->parseSignedByte();
		dirY = message->parseSignedByte();
		dirZ = message->parseSignedByte();

		directionW = dirW * directionScale;
		directionX = dirX * directionScale;
		directionY = dirY * directionScale;
		directionZ = dirZ * directionScale;

		posX = message->parseSignedShort();
		posZ = message->parseSignedShort();
		posY = message->parseSignedShort();

		positionX = posX * positionScale;
		positionY = posY * positionScale;
		positionZ = posZ * positionScale;

		velocity.parse(message);
		yawRate.parse(message);
		pitchRate.parse(message);
		rollRate.parse(message);

		counter = message->parseInt();
	}

	void run() {
		ManagedReference<CreatureObject*> pilot = client->getPlayer();
		if (pilot == nullptr) {
			return;
		}

		PlayerObject* ghost = pilot->getPlayerObject();
		if (ghost == nullptr || ghost->isTeleporting()) {
			return updateError(pilot, "!ghost", false);
		}

		ManagedReference<SceneObject*> parent = pilot->getRootParent();
		if (parent == nullptr) {
			return updateError(pilot, "!parent", false);
		}

		ShipObject* ship = parent->asShipObject();
		if (ship == nullptr|| ship->isHyperspacing()) {
			return updateError(pilot, "!ship", false);
		}

		SpaceZone* zone = ship->getSpaceZone();
		if (zone == nullptr) {
			return updateError(pilot, "!zone", false);
		}

		if (ghost->getClientLastMovementStamp() == 0 && counter != 0) {
			ghost->setClientLastMovementStamp(counter);
			return synchronize(ship, pilot);
		}

		deltaTime = (long)counter - (long)ghost->getClientLastMovementStamp();

		if (deltaTime < -Transform::SYNCDELTA) {
			return updateError(pilot, "!syncDelta", true);
		}

		if (deltaTime < Transform::MINDELTA) {
			return;
		}

		if (!isPositionValid()) {
			return updateError(pilot, "!isPositionValid", true);
		}

		Locker pLock(pilot);
		Locker cLock(ship, pilot);

		ship->setSyncStamp(counter);

		if (isPositionUpdate(ship)) {
			updatePosition(ship, pilot);
		} else if (isStaticUpdate(ship)) {
			updateStatic(ship, pilot);
		}

		auto data = new ShipUpdateTransformMessage(ship, ship->getPosition(), velocity, yawRate, pitchRate, rollRate, counter);
		pilot->sendMessage(data);

		ghost->setClientLastMovementStamp(counter);
	}

	bool isPositionValid() const {
		if (positionX > 8000.f || positionX < -8000.f || positionY > 8000.f || positionY < -8000.f || positionZ > 8000.f || positionZ < -8000.f) {
			return false;
		}

		return true;
	}

	bool isPositionUpdate(ShipObject* ship) const {
		const Vector3& position = ship->getPosition();

		if (positionX != position.getX() || positionY != position.getY() || positionZ != position.getZ()) {
			return true;
		}

		return false;
	}

	bool isStaticUpdate(ShipObject* ship) {
		const Quaternion* direction = ship->getDirection();

		if (directionW != direction->getW() || directionX != direction->getX() || directionY != direction->getY() || directionZ != direction->getZ()) {
			return true;
		}

		if (deltaTime > Transform::MAXDELTA) {
			return true;
		}

		return false;
	}

	void updateCollision(ShipObject* ship, CreatureObject* pilot, const Vector3& collisionPoint) {
#ifdef SHIP_TRANSFORM_DEBUG
		sendDebug(pilot, ship, "updateCollision", collisionPoint);
#endif // SHIP_TRANSFORM_DEBUG

		updateTransform(ship, pilot, collisionPoint, true);
		broadcastTransform(ship, pilot, collisionPoint);

		auto collide = new ShipUpdateTransformCollisionMessage(ship);
		ship->broadcastMessage(collide, false);

		auto effect = new PlayClientEffectObjectMessage(ship, "clienteffect/space_collision.cef", "");
		ship->broadcastMessage(effect, false);
	}

	void updatePosition(ShipObject* ship, CreatureObject* pilot) {
		Vector3 position(positionX, positionY, positionZ);
		/*Vector3 collisionPoint;

		if (CollisionManager::checkShipCollision(ship, position, collisionPoint)) {
			return updateCollision(ship, pilot, collisionPoint);
		}*/

#ifdef SHIP_TRANSFORM_DEBUG
		sendDebug(pilot, ship, "updatePosition", position);
#endif // SHIP_TRANSFORM_DEBUG

		updateTransform(ship, pilot, position, false);
		broadcastTransform(ship, pilot, position);
	}

	void updateStatic(ShipObject* ship, CreatureObject* pilot) {
		const Vector3& position = ship->getPosition();

#ifdef SHIP_TRANSFORM_DEBUG
		sendDebug(pilot, ship, "updateStatic", position);
#endif // SHIP_TRANSFORM_DEBUG

		updateTransform(ship, pilot, position, false);
		broadcastTransform(ship, pilot, position);
	}

	void synchronize(ShipObject* ship, CreatureObject* pilot) {
		const Vector3& position = ship->getPosition();

#ifdef SHIP_TRANSFORM_DEBUG
		sendDebug(pilot, ship, "synchronize", position);
#endif // SHIP_TRANSFORM_DEBUG

		updateTransform(ship, pilot, position, true);
	}

	void updateTransform(ShipObject* ship, CreatureObject* pilot, const Vector3& position, bool reorthonormalize) {
		Quaternion direction(directionW, directionX, directionY, directionZ);

		if (reorthonormalize) {
			direction.normalize();
		}

		ship->setPosition(position.getX(), position.getZ(), position.getY());
		ship->setDirection(direction);

		bool lightUpdate = priority != 0x23;
		ship->updateZone(lightUpdate, false);

		if (reorthonormalize) {
			auto data = new DataTransform(ship);
			pilot->sendMessage(data);
		}
	}

	void broadcastTransform(ShipObject* ship, CreatureObject* pilot, const Vector3& position) {
		auto shipCov = ship->getCloseObjects();
		if (shipCov == nullptr) {
			return;
		}

		SortedVector<ManagedReference<TreeEntry*> > closePlayers;
		shipCov->safeCopyReceiversTo(closePlayers, CloseObjectsVector::PLAYERTYPE);

		for (int i = 0; i < closePlayers.size(); ++i) {
			auto targetCreo = closePlayers.get(i).castTo<CreatureObject*>();
			if (targetCreo == nullptr || targetCreo == pilot) {
				continue;
			}

			auto targetRoot = targetCreo->getRootParent();
			if (targetRoot == nullptr || targetRoot == ship) {
				continue;
			}

			auto targetShip = targetRoot->asShipObject();
			if (targetShip == nullptr) {
				continue;
			}

			uint32 syncStamp = targetShip->getSyncStamp();

			if (velocity.getSpeed() > 0.f) {
				auto data = new ShipUpdateTransformMessage(ship, position, velocity, yawRate, pitchRate, rollRate, syncStamp);
				targetCreo->sendMessage(data);
			} else {
				auto data = new ShipUpdateTransformMessage(ship, syncStamp);
				targetCreo->sendMessage(data);
			}
		}
	}

	void updateError(CreatureObject* pilot, const String& message, bool bounceBack) {
		if (!message.isEmpty()) {
			if (message.beginsWith("@")) {
				pilot->sendSystemMessage(message);
			}

			if (errorLog && message.beginsWith("!")) {
				pilot->info(true) << " ShipUpdateTransformCallback: " << message;
			}
		}

		auto parent = pilot->getRootParent();
		if (parent == nullptr || !parent->isShipObject()) {
			return;
		}

		auto ship = parent->asShipObject();
		if (ship == nullptr) {
			return;
		}

#ifdef SHIP_TRANSFORM_DEBUG
		sendDebug(pilot, ship, "error: " + message, ship->getPosition());
#endif // SHIP_TRANSFORM_DEBUG

		if (bounceBack) {
			const Vector3& position = ship->getPosition();

			parent->teleport(position.getX(), position.getZ(), position.getY(), 0);
		}
	}

#ifdef SHIP_TRANSFORM_DEBUG
	void sendDebug(CreatureObject* pilot, ShipObject* ship, const String& message, const Vector3& position) {
		if (sendText) {
			sendDebugMessage(pilot, ship, message, position);
		}

		if (sendPath) {
			sendDebugPath(pilot, ship, position);
		}
	}

	void sendDebugMessage(CreatureObject* pilot, ShipObject* ship, const String& message, const Vector3& position) {
		StringBuffer msg;

		msg << "Transform:  " << message << endl
			<< " ShipId:    " << shipId << endl
			<< " Position:  " << positionX  << ", " << positionZ  << ", " << positionY << endl
			<< " Direction: " << directionW  << ", " << directionX  << ", " << directionY << ", " << directionZ << endl
			<< " Velocity:  " << velocity.getSpeed() << "/" << ship->getActualMaxSpeed() << endl
			<< " yawRate:   " << yawRate.get() << endl
			<< " pitchRate: " << pitchRate.get() << endl
			<< " rollRate:  " << rollRate.get() << endl
			<< " syncStamp: " << ship->getSyncStamp() << endl
			<< " counter:   " << counter << endl
			<< "--------------------------------";

		pilot->sendSystemMessage(msg.toString());
	}

	void sendDebugPath(CreatureObject* pilot, ShipObject* ship, const Vector3& nextPosition) {
		Vector3 lastPosition = ship->getPosition();
		Vector3 thisPosition = Vector3(positionX, positionY, positionZ);

		auto path = new CreateClientPathMessage();
		path->addCoordinate(lastPosition.getX(), lastPosition.getZ(), lastPosition.getY());
		path->addCoordinate(thisPosition.getX(), thisPosition.getZ(), thisPosition.getY());

		if (drawPathRadius) {
			path->addCoordinate(thisPosition.getX() + 8, thisPosition.getZ(), thisPosition.getY());
			path->addCoordinate(thisPosition.getX() - 8, thisPosition.getZ(), thisPosition.getY());
			path->addCoordinate(thisPosition.getX(), thisPosition.getZ(), thisPosition.getY());
			path->addCoordinate(thisPosition.getX(), thisPosition.getZ(), thisPosition.getY() + 8);
			path->addCoordinate(thisPosition.getX(), thisPosition.getZ(), thisPosition.getY() - 8);
			path->addCoordinate(thisPosition.getX(), thisPosition.getZ(), thisPosition.getY());
		}

		path->addCoordinate(nextPosition.getX(), nextPosition.getZ(), nextPosition.getY());
		ship->broadcastMessage(path, false);
	}
#endif // SHIP_TRANSFORM_DEBUG
};

#endif /* SHIPUPDATETRANSFORMCALLBACK_H_ */
