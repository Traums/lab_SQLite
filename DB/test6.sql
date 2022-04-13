BEGIN TRANSACTION;
DROP TABLE IF EXISTS "conversations";
CREATE TABLE IF NOT EXISTS "conversations" (
	"id"	STRING,
	"json"	TEXT,
	"active_at"	INTEGER,
	"type"	STRING,
	"members"	TEXT,
	"name"	TEXT,
	"profileName"	TEXT,
	"profileFamilyName"	TEXT,
	"profileFullName"	TEXT,
	"e164"	TEXT,
	"uuid"	TEXT,
	"groupId"	TEXT,
	"profileLastFetchedAt"	INTEGER,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "identityKeys";
CREATE TABLE IF NOT EXISTS "identityKeys" (
	"id"	STRING,
	"json"	TEXT,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "items";
CREATE TABLE IF NOT EXISTS "items" (
	"id"	STRING,
	"json"	TEXT,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "sessions";
CREATE TABLE IF NOT EXISTS "sessions" (
	"id"	TEXT,
	"conversationId"	TEXT,
	"json"	TEXT,
	"ourUuid"	STRING,
	"uuid"	STRING,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "attachment_downloads";
CREATE TABLE IF NOT EXISTS "attachment_downloads" (
	"id"	STRING,
	"timestamp"	INTEGER,
	"pending"	INTEGER,
	"json"	TEXT,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "sticker_packs";
CREATE TABLE IF NOT EXISTS "sticker_packs" (
	"id"	TEXT,
	"key"	TEXT NOT NULL,
	"author"	STRING,
	"coverStickerId"	INTEGER,
	"createdAt"	INTEGER,
	"downloadAttempts"	INTEGER,
	"installedAt"	INTEGER,
	"lastUsed"	INTEGER,
	"status"	STRING,
	"stickerCount"	INTEGER,
	"title"	STRING,
	"attemptedStatus"	STRING,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "stickers";
CREATE TABLE IF NOT EXISTS "stickers" (
	"id"	INTEGER NOT NULL,
	"packId"	TEXT NOT NULL,
	"emoji"	STRING,
	"height"	INTEGER,
	"isCoverOnly"	INTEGER,
	"lastUsed"	INTEGER,
	"path"	STRING,
	"width"	INTEGER,
	CONSTRAINT "stickers_fk" FOREIGN KEY("packId") REFERENCES "sticker_packs"("id") ON DELETE CASCADE,
	PRIMARY KEY("id","packId")
);
DROP TABLE IF EXISTS "sticker_references";
CREATE TABLE IF NOT EXISTS "sticker_references" (
	"messageId"	STRING,
	"packId"	TEXT,
	CONSTRAINT "sticker_references_fk" FOREIGN KEY("packId") REFERENCES "sticker_packs"("id") ON DELETE CASCADE
);
DROP TABLE IF EXISTS "emojis";
CREATE TABLE IF NOT EXISTS "emojis" (
	"shortName"	TEXT,
	"lastUsage"	INTEGER,
	PRIMARY KEY("shortName")
);
DROP TABLE IF EXISTS "jobs";
CREATE TABLE IF NOT EXISTS "jobs" (
	"id"	TEXT,
	"queueType"	TEXT STRING NOT NULL,
	"timestamp"	INTEGER NOT NULL,
	"data"	STRING TEXT,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "reactions";
CREATE TABLE IF NOT EXISTS "reactions" (
	"conversationId"	STRING,
	"emoji"	STRING,
	"fromId"	STRING,
	"messageReceivedAt"	INTEGER,
	"targetAuthorUuid"	STRING,
	"targetTimestamp"	INTEGER,
	"unread"	INTEGER,
	"messageId"	STRING
);
DROP TABLE IF EXISTS "senderKeys";
CREATE TABLE IF NOT EXISTS "senderKeys" (
	"id"	TEXT NOT NULL,
	"senderId"	TEXT NOT NULL,
	"distributionId"	TEXT NOT NULL,
	"data"	BLOB NOT NULL,
	"lastUpdatedDate"	NUMBER NOT NULL,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "unprocessed";
CREATE TABLE IF NOT EXISTS "unprocessed" (
	"id"	STRING,
	"timestamp"	INTEGER,
	"version"	INTEGER,
	"attempts"	INTEGER,
	"envelope"	TEXT,
	"decrypted"	TEXT,
	"source"	TEXT,
	"deprecatedSourceDevice"	TEXT,
	"serverTimestamp"	INTEGER,
	"sourceUuid"	STRING,
	"serverGuid"	STRING,
	"sourceDevice"	INTEGER,
	"receivedAtCounter"	INTEGER,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "sendLogPayloads";
CREATE TABLE IF NOT EXISTS "sendLogPayloads" (
	"id"	INTEGER,
	"timestamp"	INTEGER NOT NULL,
	"contentHint"	INTEGER NOT NULL,
	"proto"	BLOB NOT NULL,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "sendLogRecipients";
CREATE TABLE IF NOT EXISTS "sendLogRecipients" (
	"payloadId"	INTEGER NOT NULL,
	"recipientUuid"	STRING NOT NULL,
	"deviceId"	INTEGER NOT NULL,
	CONSTRAINT "sendLogRecipientsForeignKey" FOREIGN KEY("payloadId") REFERENCES "sendLogPayloads"("id") ON DELETE CASCADE,
	PRIMARY KEY("payloadId","recipientUuid","deviceId")
);
DROP TABLE IF EXISTS "sendLogMessageIds";
CREATE TABLE IF NOT EXISTS "sendLogMessageIds" (
	"payloadId"	INTEGER NOT NULL,
	"messageId"	STRING NOT NULL,
	CONSTRAINT "sendLogMessageIdsForeignKey" FOREIGN KEY("payloadId") REFERENCES "sendLogPayloads"("id") ON DELETE CASCADE,
	PRIMARY KEY("payloadId","messageId")
);
DROP TABLE IF EXISTS "groupCallRings";
CREATE TABLE IF NOT EXISTS "groupCallRings" (
	"ringId"	INTEGER,
	"isActive"	INTEGER NOT NULL,
	"createdAt"	INTEGER NOT NULL,
	PRIMARY KEY("ringId")
);
DROP TABLE IF EXISTS "preKeys";
CREATE TABLE IF NOT EXISTS "preKeys" (
	"id"	STRING,
	"json"	TEXT,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "signedPreKeys";
CREATE TABLE IF NOT EXISTS "signedPreKeys" (
	"id"	STRING,
	"json"	TEXT,
	PRIMARY KEY("id" ASC)
);
DROP TABLE IF EXISTS "badges";
CREATE TABLE IF NOT EXISTS "badges" (
	"id"	TEXT,
	"category"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"descriptionTemplate"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "badgeImageFiles";
CREATE TABLE IF NOT EXISTS "badgeImageFiles" (
	"badgeId"	TEXT,
	"order"	INTEGER NOT NULL,
	"url"	TEXT NOT NULL,
	"localPath"	TEXT,
	"theme"	TEXT NOT NULL,
	FOREIGN KEY("badgeId") REFERENCES "badges"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
DROP TABLE IF EXISTS "storyReads";
CREATE TABLE IF NOT EXISTS "storyReads" (
	"authorId"	STRING NOT NULL,
	"conversationId"	STRING NOT NULL,
	"storyId"	STRING NOT NULL,
	"storyReadDate"	NUMBER NOT NULL,
	PRIMARY KEY("authorId","storyId")
);
DROP TABLE IF EXISTS "storyDistributions";
CREATE TABLE IF NOT EXISTS "storyDistributions" (
	"id"	STRING NOT NULL,
	"name"	TEXT,
	"avatarUrlPath"	TEXT,
	"avatarKey"	BLOB,
	"senderKeyInfoJson"	STRING,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "storyDistributionMembers";
CREATE TABLE IF NOT EXISTS "storyDistributionMembers" (
	"listId"	STRING NOT NULL,
	"uuid"	STRING NOT NULL,
	FOREIGN KEY("listId") REFERENCES "storyDistributions"("id") ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY("listId","uuid")
);
INSERT INTO "conversations" ("id","json","active_at","type","members","name","profileName","profileFamilyName","profileFullName","e164","uuid","groupId","profileLastFetchedAt") VALUES ('9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f','{"unreadCount":0,"verified":0,"messageCount":0,"sentMessageCount":0,"id":"9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f","uuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","e164":"+79221168221","groupId":null,"type":"private","version":2,"sealedSender":1,"color":"A170","profileKeyCredential":"AEYxK1Lt5LJ2u/xAR+7eq1WnIBgoLxB3+Q51prG4oZIAWM93gcRpaIzYZt68HgcdXIo4OMkg7b18Et5o8h109D2mO+eThG9ChKnTrQ/fX8+t4RiWjcCViEhjCszAl3fRG1BA0Ir7PEaJqpoBF5h5s5xWiGiC0+AFGAsOZDHcr0FN/Ub1Y5ptAs/YVWUzIzcpuw==","accessKey":"03H6fTENmp8TElvpTpt41w==","profileKey":"VohogtPgBRgLDmQx3K9BTf1G9WOabQLP2FVlMyM3Kbs=","needsStorageServiceSync":false,"capabilities":{"gv2":true,"senderKey":true,"announcementGroup":true,"changeNumber":true,"stories":true,"gv1-migration":true},"profileName":"Дима","lastProfile":{"profileKey":"VohogtPgBRgLDmQx3K9BTf1G9WOabQLP2FVlMyM3Kbs=","profileKeyVersion":"442ea634caeabf073bdaf6ef7ebedb4c40ef89fa704276642f293d9985345a1e"},"messageCountBeforeMessageRequests":0,"avatar":null,"storageVersion":2,"storageID":"tdorOHkCW9Yizfh8OkUmUw==","storageUnknownFields":"ggEA","isArchived":false,"markedUnread":false}',NULL,'private',NULL,NULL,'Дима',NULL,'Дима','+79221168221','5040d08a-fb3c-4689-aa9a-01179879b39c',NULL,1649843817517),
 ('e2b7c019-dbb5-438b-8502-1916ff987e21','{"unreadCount":0,"verified":0,"messageCount":0,"sentMessageCount":0,"id":"e2b7c019-dbb5-438b-8502-1916ff987e21","uuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","e164":null,"groupId":null,"type":"private","version":2,"sealedSender":0,"color":"A190","messageCountBeforeMessageRequests":0,"needsStorageServiceSync":false,"storageVersion":2,"storageID":"Lw3WQjjsPC5B9yX2/2g2tg==","hideStory":false,"isArchived":false,"markedUnread":false,"muteExpiresAt":0}',NULL,'private',NULL,NULL,NULL,NULL,NULL,NULL,'c06df00a-b805-4371-bd28-4a717ba66a8c',NULL,NULL),
 ('77ea11a5-c303-46ac-ae74-93915ffaaa2b','{"unreadCount":0,"verified":0,"messageCount":1,"sentMessageCount":1,"id":"77ea11a5-c303-46ac-ae74-93915ffaaa2b","uuid":"7cbda643-87ea-426c-aea6-6febdaaed40c","e164":"+79220390745","groupId":null,"type":"private","version":2,"sealedSender":2,"color":"A140","name":"Петя","avatar":null,"needsStorageServiceSync":false,"storageVersion":1,"storageID":"EtnRs+vQGdJNVIA/TW/+7w==","markedUnread":false,"lastMessage":"ТЕстовая проверка","lastMessageStatus":"delivered","timestamp":1649843843306,"sharedGroupNames":[],"capabilities":{"gv2":true,"senderKey":true,"announcementGroup":true,"changeNumber":true,"stories":false,"gv1-migration":true},"active_at":1649843843306,"draft":"","draftBodyRanges":[],"draftChanged":true,"quotedMessageId":null,"draftAttachments":[],"draftTimestamp":null,"profileSharing":true,"isArchived":false}',1649843843306,'private',NULL,'Петя',NULL,NULL,NULL,'+79220390745','7cbda643-87ea-426c-aea6-6febdaaed40c',NULL,1649843833252),
 ('00556194-dd17-4a5b-8d94-9bb55b21fa2b','{"unreadCount":0,"verified":0,"messageCount":0,"sentMessageCount":0,"id":"00556194-dd17-4a5b-8d94-9bb55b21fa2b","uuid":"ce56a3e4-7de6-4ed7-88fe-f1b367879e50","e164":"+79045498939","groupId":null,"type":"private","version":2,"sealedSender":0,"color":"A200","name":"Шейкмана Риэлтор","avatar":null,"needsStorageServiceSync":false,"storageVersion":2,"storageID":"uq5fEH5VEqtPW/l+BsGDFg==","hideStory":false,"isArchived":false,"markedUnread":false,"muteExpiresAt":0}',NULL,'private',NULL,'Шейкмана Риэлтор',NULL,NULL,NULL,'+79045498939','ce56a3e4-7de6-4ed7-88fe-f1b367879e50',NULL,NULL);
INSERT INTO "identityKeys" ("id","json") VALUES ('5040d08a-fb3c-4689-aa9a-01179879b39c','{"firstUse":true,"timestamp":1649843816171,"verified":1,"nonblockingApproval":true,"publicKey":"BX+yUiibgBPRXyRtBp9hwVhSAqxiSpvV/uB0E3D4FIBc","id":"5040d08a-fb3c-4689-aa9a-01179879b39c"}'),
 ('7cbda643-87ea-426c-aea6-6febdaaed40c','{"id":"7cbda643-87ea-426c-aea6-6febdaaed40c","publicKey":"BWyjy7WHbcXc1+3mBSJuXo4ZyTB+sNasXJrY5Xr7CIEc","firstUse":true,"timestamp":1649843833249,"verified":0,"nonblockingApproval":false}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c','{"firstUse":true,"timestamp":1649843816171,"verified":0,"nonblockingApproval":true,"publicKey":"BV7WmwLyoAJ3SVVv87UNN6+8HEZv2Yp7m/ICIKDwI6tP","id":"c06df00a-b805-4371-bd28-4a717ba66a8c"}'),
 ('ce56a3e4-7de6-4ed7-88fe-f1b367879e50','{"publicKey":"BQUyUcisMOSUB7JWTLySVIpaVSC7EOvc+Cs0ffSXgSYy","verified":0,"firstUse":false,"timestamp":1649843849745,"nonblockingApproval":false,"id":"ce56a3e4-7de6-4ed7-88fe-f1b367879e50"}');
INSERT INTO "items" ("id","json") VALUES ('number_id','{"id":"number_id","value":"+79221168221.2"}'),
 ('uuid_id','{"id":"uuid_id","value":"5040d08a-fb3c-4689-aa9a-01179879b39c.2"}'),
 ('password','{"id":"password","value":"4NSzK/4w2PR6n15VW+hnow"}'),
 ('pni','{"id":"pni","value":"c06df00a-b805-4371-bd28-4a717ba66a8c"}'),
 ('device_name','{"id":"device_name","value":"DESKTOP-5B9TP16"}'),
 ('identityKeyMap','{"id":"identityKeyMap","value":{"5040d08a-fb3c-4689-aa9a-01179879b39c":{"pubKey":"BX+yUiibgBPRXyRtBp9hwVhSAqxiSpvV/uB0E3D4FIBc","privKey":"eLI1R+ycrHWWumnsQSq6voZ0BhwaC/rz0MvIkspd3Xg="},"c06df00a-b805-4371-bd28-4a717ba66a8c":{"pubKey":"BV7WmwLyoAJ3SVVv87UNN6+8HEZv2Yp7m/ICIKDwI6tP","privKey":"APRV/iuqyyNzpH3CvDhKZ3BMFcf2W85DLNgsLh+gIGw="}}}'),
 ('registrationIdMap','{"id":"registrationIdMap","value":{"5040d08a-fb3c-4689-aa9a-01179879b39c":16245,"c06df00a-b805-4371-bd28-4a717ba66a8c":16245}}'),
 ('userAgent','{"id":"userAgent","value":"OWI"}'),
 ('regionCode','{"id":"regionCode","value":"RU"}'),
 ('maxPreKeyId','{"id":"maxPreKeyId","value":101}'),
 ('signedKeyId','{"id":"signedKeyId","value":2}'),
 ('chromiumRegistrationDoneEver','{"id":"chromiumRegistrationDoneEver","value":""}'),
 ('chromiumRegistrationDone','{"id":"chromiumRegistrationDone","value":""}'),
 ('remoteConfig','{"id":"remoteConfig","value":{"desktop.gv2":{"name":"desktop.gv2","enabled":true,"value":"TRUE"},"desktop.canResizeLeftPane.beta":{"name":"desktop.canResizeLeftPane.beta","enabled":true,"value":null},"desktop.storageWrite":{"name":"desktop.storageWrite","enabled":false,"value":"FALSE"},"desktop.canResizeLeftPane.production":{"name":"desktop.canResizeLeftPane.production","enabled":true,"value":null},"desktop.usernames":{"name":"desktop.usernames","enabled":false,"value":null},"desktop.cds":{"name":"desktop.cds","enabled":true,"value":"TRUE"},"desktop.retryRespondMaxAge":{"name":"desktop.retryRespondMaxAge","enabled":false,"value":"1209600000"},"desktop.senderKey.retry":{"name":"desktop.senderKey.retry","enabled":true,"value":null},"desktop.storageWrite3":{"name":"desktop.storageWrite3","enabled":true,"value":"TRUE"},"desktop.senderKeyMaxAge":{"name":"desktop.senderKeyMaxAge","enabled":true,"value":"1209600000"},"desktop.gv2Admin":{"name":"desktop.gv2Admin","enabled":false,"value":"FALSE"},"desktop.sendSenderKey2":{"name":"desktop.sendSenderKey2","enabled":false,"value":null},"desktop.groupCallOutboundRing":{"name":"desktop.groupCallOutboundRing","enabled":false,"value":null},"desktop.showUserBadges2":{"name":"desktop.showUserBadges2","enabled":true,"value":null},"desktop.senderKey.send":{"name":"desktop.senderKey.send","enabled":true,"value":null},"desktop.storage":{"name":"desktop.storage","enabled":true,"value":"TRUE"},"desktop.worksAtSignal":{"name":"desktop.worksAtSignal","enabled":false,"value":null},"desktop.mandatoryProfileSharing":{"name":"desktop.mandatoryProfileSharing","enabled":true,"value":null},"desktop.announcementGroup":{"name":"desktop.announcementGroup","enabled":true,"value":null},"desktop.mediaQuality.levels":{"name":"desktop.mediaQuality.levels","enabled":true,"value":"1:2,61:2,81:2,82:2,65:2,31:2,47:2,41:2,32:2,385:2,971:2,974:2,49:2,33:2,*:1"},"desktop.calling.audioLevelForSpeaking":{"name":"desktop.calling.audioLevelForSpeaking","enabled":true,"value":"0.15"},"desktop.sendSenderKey3":{"name":"desktop.sendSenderKey3","enabled":true,"value":null},"desktop.disableGV1":{"name":"desktop.disableGV1","enabled":true,"value":"TRUE"},"desktop.messageRequests":{"name":"desktop.messageRequests","enabled":true,"value":"TRUE"},"desktop.internalUser":{"name":"desktop.internalUser","enabled":false,"value":null},"desktop.customizePreferredReactions":{"name":"desktop.customizePreferredReactions","enabled":false,"value":null},"desktop.showUserBadges.beta":{"name":"desktop.showUserBadges.beta","enabled":true,"value":null},"desktop.storageWrite2":{"name":"desktop.storageWrite2","enabled":false,"value":"FALSE"},"desktop.messageCleanup":{"name":"desktop.messageCleanup","enabled":false,"value":null},"desktop.retryReceiptLifespan":{"name":"desktop.retryReceiptLifespan","enabled":false,"value":"3600000"},"desktop.groupCalling":{"name":"desktop.groupCalling","enabled":true,"value":"TRUE"},"desktop.calling.useWindowsAdm2":{"name":"desktop.calling.useWindowsAdm2","enabled":true,"value":null},"desktop.showUserBadges":{"name":"desktop.showUserBadges","enabled":true,"value":null},"global.groupsv2.maxGroupSize":{"name":"global.groupsv2.maxGroupSize","enabled":true,"value":"151"},"global.groupsv2.groupSizeHardLimit":{"name":"global.groupsv2.groupSizeHardLimit","enabled":true,"value":"1001"},"global.calling.maxGroupCallRingSize":{"name":"global.calling.maxGroupCallRingSize","enabled":true,"value":"16"},"global.payments.disabledRegions":{"name":"global.payments.disabledRegions","enabled":true,"value":"98,963,53,850,7 978,7 365,7 869,7 941"},"global.attachments.maxBytes":{"name":"global.attachments.maxBytes","enabled":true,"value":"104857600"}}}'),
 ('nextSignedKeyRotationTime','{"id":"nextSignedKeyRotationTime","value":1650016618181}'),
 ('lastAttemptedToRefreshProfilesAt','{"id":"lastAttemptedToRefreshProfilesAt","value":1649843818189}'),
 ('groupCredentials','{"id":"groupCredentials","value":[{"redemptionTime":19095,"credential":"AM/utKm3jvmr2I4ba6qy83m/NvK2vNk28Jh/XByqIXYEpCnw15Y0ljijRVgGBB+JSSbzXwaaxDhLHjVm6uLjMmhi5y973dM9BKVc46xDpMNWE+4ASZ0WAdzUwl9cMl2PPlBA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFel0oAAA=="},{"redemptionTime":19096,"credential":"AGsbDWTloib/R9aXypMmgpZgi4pJUgTNU+3e51hh3ccI8k0dORFlyCAWomB6+ewGn8RZCSOItJ0HIWp18latiUVS/0TgyXO/QR4+v4BzYwyyamxb07ORBSHf3ru4NZ6AIFBA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFemEoAAA=="},{"redemptionTime":19097,"credential":"ADZbHd1T8YBUyr9jVFakZjnIIBVh4xlwBN6+lpODspMI0lRK8H5eH2ux59XNQBAo79RTeB4E/h8qv51K4/xVtQTQ9I2Du2SskMPv8oCWqp2cXdZwKfffRAQjfzaXgsdOcFBA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFemUoAAA=="},{"redemptionTime":19098,"credential":"AKh0fUFGoXe+O8RW68+lZUOjHD7z9dAk+MR+igrWwfQDJLY5+cGBSVt8CDMruuaZEJuCvLj1LVlAd6L+OQw7KVCGQqg2JobIjAv2PHlJ5m8Ie2LcLUxnzDi1lbpB69XnEVBA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFemkoAAA=="},{"redemptionTime":19099,"credential":"AMO3P/rwvFocEtrx0FErUqDy7orN2qBFyXxUc//9ndsGBtvd+T7bfuq60wmkPSGE2UBHXnJKR7cv5YY4BaFVizKY01XnF+w5rJ1079jk1GXC1miC+tzhkHoN8ebOYcCRMVBA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFem0oAAA=="},{"redemptionTime":19100,"credential":"AFcmihkoJX4ZG7lXn9diyxT4LhGo1H+G4qsFiycNfm8LUOPd0cvb7Wqp4peq+nlKcE/oC5m8P44qNFCy0SjzSUpyvSszhN1n+FUIJnnjMEbrVBqM0mHB/+U2AzNmD/5dD1BA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFenEoAAA=="},{"redemptionTime":19101,"credential":"AMbquWKXalWCK9oS41zmUm8hxawwqx1W5nc8iPsbSd4FtDuGfmhr8FpKuzn3pY1taTNSlnQiS3PwUOtFomnlm3Cgu82hKOMQSYkNbYIVTYDMT2LGiiFBBiZOy5B34MQ9C1BA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFenUoAAA=="},{"redemptionTime":19102,"credential":"AG4LUrxtPthuTWpn27SJqvj83rBPLZmuO04HvZbexgYLDIARuptF6841uiZnYW/jvoGFfB/5wIl6fKIQqDW1D1LE8P+pv657jzOrfsTmrdsoeReQPmBZ2ATQGzmEMNuBP1BA0Ir7PEaJqpoBF5h5s5w2UzgfKlaepJ/0thEBZwrBHDgiDkKbHOtGF+o2EVwPPAgYKgB3AfV2/8fcVelTpYEacnFErwzrCsP37h6PiiFenkoAAA=="}]}'),
 ('hasRegisterSupportForUnauthenticatedDelivery','{"id":"hasRegisterSupportForUnauthenticatedDelivery","value":true}'),
 ('theme-setting','{"id":"theme-setting","value":"system"}'),
 ('unidentifiedDeliveryIndicators','{"id":"unidentifiedDeliveryIndicators","value":false}'),
 ('blocked','{"id":"blocked","value":[]}'),
 ('blocked-uuids','{"id":"blocked-uuids","value":[]}'),
 ('blocked-groups','{"id":"blocked-groups","value":[]}'),
 ('storageKey','{"id":"storageKey","value":"Kszc/0mTu7flwMciYHEKCdt+JXtBun+0OBKS5HN/1yM="}'),
 ('synced_at','{"id":"synced_at","value":1649843823017}'),
 ('senderCertificate','{"id":"senderCertificate","value":{"expires":1650447742979,"serialized":"Cs0BCgwrNzkyMjExNjgyMjEQAhmjs2dGgAEAACIhBX+yUiibgBPRXyRtBp9hwVhSAqxiSpvV/uB0E3D4FIBcKmkKJQgBEiEFdUMjcS5ytG1NqDjdyJ105jFx4m0UZZZGinS98eiWSWUSQB8y83lxaj0e/L/LC2nzOGXuuN8yaBda9wDVgUyoYll9A+e3V0hCNEt6OISEBwGOF8E5oP/jc5Rl0NwKJ2Ge3Q8yJDUwNDBkMDhhLWZiM2MtNDY4OS1hYTlhLTAxMTc5ODc5YjM5YxJADYzu9QNKXsxiNxmo3mH0vCjssQDiN1zvCEKojb6RwkwjUDH4WUGey5CH1joMKmWeCPmxdnNMVCrbMSys3GEVBw=="}}'),
 ('unreadCount','{"id":"unreadCount","value":0}'),
 ('storageCredentials','{"id":"storageCredentials","value":{"username":"5040d08a-fb3c-4689-aa9a-01179879b39c","password":"5040d08a-fb3c-4689-aa9a-01179879b39c:1649843854:123ef1ec6e8fc71cd8f5"}}'),
 ('read-receipt-setting','{"id":"read-receipt-setting","value":true}'),
 ('sealedSenderIndicators','{"id":"sealedSenderIndicators","value":false}'),
 ('typingIndicators','{"id":"typingIndicators","value":true}'),
 ('linkPreviews','{"id":"linkPreviews","value":true}'),
 ('preferContactAvatars','{"id":"preferContactAvatars","value":false}'),
 ('primarySendsSms','{"id":"primarySendsSms","value":false}'),
 ('accountE164','{"id":"accountE164","value":"+79221168221"}'),
 ('preferredReactionEmoji','{"id":"preferredReactionEmoji","value":[]}'),
 ('universalExpireTimer','{"id":"universalExpireTimer","value":0}'),
 ('phoneNumberSharingMode','{"id":"phoneNumberSharingMode","value":"Everybody"}'),
 ('phoneNumberDiscoverability','{"id":"phoneNumberDiscoverability","value":"Discoverable"}'),
 ('profileKey','{"id":"profileKey","value":"VohogtPgBRgLDmQx3K9BTf1G9WOabQLP2FVlMyM3Kbs="}'),
 ('pinnedConversationIds','{"id":"pinnedConversationIds","value":[]}'),
 ('subscriberId','{"id":"subscriberId","value":""}'),
 ('subscriberCurrencyCode','{"id":"subscriberCurrencyCode","value":""}'),
 ('displayBadgesOnProfile','{"id":"displayBadgesOnProfile","value":false}'),
 ('avatarUrl','{"id":"avatarUrl","value":""}'),
 ('storage-service-unknown-records','{"id":"storage-service-unknown-records","value":[]}'),
 ('storage-service-error-records','{"id":"storage-service-error-records","value":[]}'),
 ('storage-service-pending-deletes','{"id":"storage-service-pending-deletes","value":[]}'),
 ('manifestVersion','{"id":"manifestVersion","value":2}'),
 ('storageFetchComplete','{"id":"storageFetchComplete","value":true}');
INSERT INTO "sessions" ("id","conversationId","json","ourUuid","uuid") VALUES ('5040d08a-fb3c-4689-aa9a-01179879b39c:5040d08a-fb3c-4689-aa9a-01179879b39c.2','9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:5040d08a-fb3c-4689-aa9a-01179879b39c.2","version":2,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","conversationId":"9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f","uuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","deviceId":2,"record":"CvACCAMSIQV/slIom4AT0V8kbQafYcFYUgKsYkqb1f7gdBNw+BSAXBohBX+yUiibgBPRXyRtBp9hwVhSAqxiSpvV/uB0E3D4FIBcIiDraUge7FCm4xQ5cGiP8vp1Mj6Ww8oKvkfqq3Lr25J2QjJpCiEFctVWB35/7QJ3XxEJhNHLiITAof276891ZHTKhRi3XTUSIPhOeeb01fQZs9b5PkG+9rROs3cO2IJtdrlgKP/AfP9+GiISIJ84I4KOBbyfTLES8dyHqe8n2GjiB1ub8oNZ3K6xAOC5OkcKIQWMAfqLRJs1/0wB42eX1ppThgrG97QAjKJam37/HJwNcxoiEiBhjy1Pb5RgB3ErCuuG9bEZ6fICh4wjy8mjYhYHAuFtYEonCAESIQWzAMhXUfzYpA5Ttg+ZHUuUKZDCUSTjKImp5Be/HetjTxgBUPV+WPV+aiEFswDIV1H82KQOU7YPmR1LlCmQwlEk4yiJqeQXvx3rY08="}','5040d08a-fb3c-4689-aa9a-01179879b39c','5040d08a-fb3c-4689-aa9a-01179879b39c'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:7cbda643-87ea-426c-aea6-6febdaaed40c.1','77ea11a5-c303-46ac-ae74-93915ffaaa2b','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:7cbda643-87ea-426c-aea6-6febdaaed40c.1","version":2,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","conversationId":"77ea11a5-c303-46ac-ae74-93915ffaaa2b","uuid":"7cbda643-87ea-426c-aea6-6febdaaed40c","deviceId":1,"record":"CvkCCAMSIQV/slIom4AT0V8kbQafYcFYUgKsYkqb1f7gdBNw+BSAXBohBWyjy7WHbcXc1+3mBSJuXo4ZyTB+sNasXJrY5Xr7CIEcIiBZFL944mRu4wRYVBJSPKz2jwEkHyl0k4H9c4yGFQvNKjJrCiEFV0dkXtoyL0Ob93s06c2UwIH67VOgemu0QGB0chm4+h8SIFB3Ghr5pGc36AWfNyqTYU/IrqP+wNhX+JC/LOWGrKVrGiQIAhIgbQz6XHWFzkyAu48xdpCjykdFDEvrFmhQJacxOMfJCX06RwohBRa4jzxcW3EdmaAWMOwA/1a9O8XPa4nDr9V7f4acKcZKGiISIE6h3audsk6oj9MAga+KeBcLY55POavIromYRyvtqcKmSi4ImJfQAhIhBX57Hugmai0KRfVOO85f9iXkgjfOCHnBNbpM6K6shgMKGKW2oZsGUKZ1WPV+aiEFfnse6CZqLQpF9U47zl/2JeSCN84IecE1ukzorqyGAwo="}','5040d08a-fb3c-4689-aa9a-01179879b39c','7cbda643-87ea-426c-aea6-6febdaaed40c'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:5040d08a-fb3c-4689-aa9a-01179879b39c.1','9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:5040d08a-fb3c-4689-aa9a-01179879b39c.1","version":2,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","conversationId":"9b6ab6e4-f8cc-4ebc-8f93-dbf1f3fae96f","uuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","deviceId":1,"record":"CuEDCAMSIQV/slIom4AT0V8kbQafYcFYUgKsYkqb1f7gdBNw+BSAXBohBX+yUiibgBPRXyRtBp9hwVhSAqxiSpvV/uB0E3D4FIBcIiDinCWY4bExj9COFTVhCCDAHAbxwm9KKqdVM7xfaskscigCMmsKIQUZhe2f0vakqh5CzAFSaGUYlZG2PqtVVG+Z3T1ac/x0PxIgcJRFnCxYrPDa5SXzrZrBqmMGpzVSWyHyVF3xY8Y0SlEaJAgCEiBmnP9Lw/+r+jb0l8lKaS/gUlE+aqeCLoLX2IdzqJI82zpHCiEFEQqyutrbLCWLRCDefygfxoDxJm8azcD5CocEuCLiXUwaIhIgMoD4MZLVHalKdZOreptAm4dpcqbVs8CmAjRsz5iekjg6SQohBfKPFSv2bZC8ukJWDFCPzIKZD7Iot0uyIbnuH5ue6a5tGiQIBRIg2sLXYHDQ5DoNC6eFzTdXRxgIrmYZ2QBta8xxEMAaYWE6SQohBQkAdC5lNev9x5Fdm2QocmUrdvqgXHTMNU830yb7gRlTGiQIARIgrO7w1V5nFxgtmhaAgGTvNZWDJBCn5rpXmH7tIqV4CzJQ2Q5Y9X5qIQXmApWCtAyqvWUc7hIKrV4pSPd8iLFdjA88CBV5k2r0JA=="}','5040d08a-fb3c-4689-aa9a-01179879b39c','5040d08a-fb3c-4689-aa9a-01179879b39c');
INSERT INTO "sticker_packs" ("id","key","author","coverStickerId","createdAt","downloadAttempts","installedAt","lastUsed","status","stickerCount","title","attemptedStatus") VALUES ('9acc9e8aba563d26a4994e69263e3b25','Wm3/OUjCjvubeq+T7MN1xp/DFueAd+0mhnoU0QoPahI=','Agnes Lee',24,1649843818502,1,NULL,NULL,'downloaded',24,'Bandit the Cat','downloaded'),
 ('fb535407d2f6497ec074df8b9c51dd1d','F+lxwTQDViJ4HS7iSeZHO3dFg3ULaMEbuCt1CcaLbf0=','Arrow Bowie',25,1649843819475,1,NULL,NULL,'downloaded',25,'Zozo the French Bulldog','downloaded'),
 ('e61fa0867031597467ccc036cc65d403','E657GnQHMYKA6bOMEmHe044OcTi5+WSmzLtz5A9zeps=','Swoon',29,1649843820467,1,NULL,NULL,'downloaded',29,'Swoon / Hands','downloaded'),
 ('cca32f5b905208b7d0f1e17f23fdc185','i/jpX3pFver+DI9bAC7wGrlbjxtbqsQBnM1ra+Cxg3o=','Swoon',89,1649843821664,1,NULL,NULL,'downloaded',89,'Swoon / Faces','downloaded'),
 ('ccc89a05dc077856b57351e90697976c','RXMOYPCdVWYRUiN0RTemt9nqmc7qy3eh+9aAG5YH+88=','Plastic Thing',0,1649843824920,1,NULL,NULL,'downloaded',24,'My Daily Life','downloaded');
INSERT INTO "stickers" ("id","packId","emoji","height","isCoverOnly","lastUsed","path","width") VALUES (24,'9acc9e8aba563d26a4994e69263e3b25','',512,1,NULL,'a4\a4b857404525aca7466b02644df84f2bd0e82b7366888dcb95f56819dc05d903',512),
 (0,'9acc9e8aba563d26a4994e69263e3b25','👍',512,0,NULL,'9e\9ee2a62c2e5f5fdc5d0806cc55b70dc2b5ec2f315d3c88d97a9be1a0a197750f',512),
 (3,'9acc9e8aba563d26a4994e69263e3b25','😒',512,0,NULL,'1f\1fa783c217007b06f20b8515cf10cc98751aeb4f50b58c77d58b926ddddf1764',512),
 (1,'9acc9e8aba563d26a4994e69263e3b25','😔',512,0,NULL,'22\224e37461276b8932ad7f62312916457bbd7325507237fa7c1ee96d832d23b12',512),
 (2,'9acc9e8aba563d26a4994e69263e3b25','🤣',512,0,NULL,'cd\cd2f2858d8534a29f9b881210f6ac354ad18b67edda6c36e155882b29d80535e',512),
 (4,'9acc9e8aba563d26a4994e69263e3b25','😴',512,0,NULL,'c9\c9fe5ab5d35e588aeb479e29a76526f581ecb1ee05267c67d55543c83f36f999',512),
 (5,'9acc9e8aba563d26a4994e69263e3b25','😇',512,0,NULL,'eb\eb194c0fb81e9c08df12d7c7a5375415d02613e62bc8cc6526a75ed8413f46f9',512),
 (6,'9acc9e8aba563d26a4994e69263e3b25','😎',512,0,NULL,'0f\0f632251f0151807da143591f5d65e7bd9a3df66aa53f31919085d0d400d6884',512),
 (8,'9acc9e8aba563d26a4994e69263e3b25','💬',512,0,NULL,'6b\6b9583ba5fc9304f001cb9ef76a760d596e15fc639a03ceb6a29c44333791341',512),
 (7,'9acc9e8aba563d26a4994e69263e3b25','😡',512,0,NULL,'e5\e594f8020fe43e5dd245feef89880896155dc1b9e66bfc28d3a4c50bea9e7fa5',512),
 (9,'9acc9e8aba563d26a4994e69263e3b25','🙏',512,0,NULL,'43\43204f8c3490b7960f7e04c79f81fd9f253dbe17d005f36ecd446d0018bdc3ce',512),
 (10,'9acc9e8aba563d26a4994e69263e3b25','🙌',512,0,NULL,'14\142f4756e99e57c67ab9d9bfd68807993d38dee23a9d1d1743949276463aa93c',512),
 (11,'9acc9e8aba563d26a4994e69263e3b25','😾',512,0,NULL,'9b\9bfccc6baadfad6a2420b6c9ea6a009f57c4a8779a347d90021654327a5d7256',512),
 (12,'9acc9e8aba563d26a4994e69263e3b25','🤔',512,0,NULL,'6a\6af74b6f7b82bbde378c85544a3615b131d5f3b0b71aa34107348e3b50166de0',512),
 (15,'9acc9e8aba563d26a4994e69263e3b25','😿',512,0,NULL,'d9\d96933b5829192454be9a5099e84f745a901c6310c5baf4579e0e43527f96623',512),
 (13,'9acc9e8aba563d26a4994e69263e3b25','🏖️',512,0,NULL,'2c\2c022da8206fbf9c1a0c73693668739e9e959a7ef9f0d9be275b95a07b156f50',512),
 (14,'9acc9e8aba563d26a4994e69263e3b25','🎉',512,0,NULL,'64\64d5d1fe2a6152a0905d4ce661e506e5fad741763db72909e04aecda668905f2',512),
 (18,'9acc9e8aba563d26a4994e69263e3b25','😤',512,0,NULL,'c0\c05449298c65b195e949cf2c05eb0a7cad726798057b1bc833bb27002e13ed82',512),
 (16,'9acc9e8aba563d26a4994e69263e3b25','😸',512,0,NULL,'7a\7a78aec3fbccfd3f0dc1cace620062e949d30190572801dbe27c50b943443628',512),
 (17,'9acc9e8aba563d26a4994e69263e3b25','😻',512,0,NULL,'ad\adba1ae30d1535c856b65955a9aab76968abaa8445385921a3c8503423af34f6',512),
 (19,'9acc9e8aba563d26a4994e69263e3b25','🤒',512,0,NULL,'15\151011e44f248e3e734164771c8b212cc9b70c19f587e842276b3b4930c6e994',512),
 (21,'9acc9e8aba563d26a4994e69263e3b25','😥',512,0,NULL,'c8\c8eef668f7b84a6d9fb079de1bbc8730c8c79819f9b7422250fed62c30603fe2',512),
 (20,'9acc9e8aba563d26a4994e69263e3b25','😠',512,0,NULL,'0d\0d6ff1fa9b0a7970e87c5fd5ef3ced0869ad18f24cdc7cf7f96d480f8ada29b4',512),
 (23,'9acc9e8aba563d26a4994e69263e3b25','😫',512,0,NULL,'cc\cc4218fac8f398f250ae5f3fb5addf9b7498673268a92f3467490a6f9f4f8587',512),
 (22,'9acc9e8aba563d26a4994e69263e3b25','😘',512,0,NULL,'4d\4d04be9abf0cb974a08425fbffd537772baaa43c62569a65b27ff18e6e45af2f',512),
 (25,'fb535407d2f6497ec074df8b9c51dd1d','',512,1,NULL,'fc\fccfa9752590964c3da541101c79dd5db77f5ffe0f43c1e3a3a20785f9d56b75',512),
 (0,'fb535407d2f6497ec074df8b9c51dd1d','✨',512,0,NULL,'f2\f203e2bc40e073716273e8b08e280a2490c274aea155dc5a5e01a553e2babeca',512),
 (2,'fb535407d2f6497ec074df8b9c51dd1d','😭',512,0,NULL,'ed\edf2e74d9add477b5e84d7d9ecff692c1a196ef55f184c189efdb75bbeda1481',512),
 (1,'fb535407d2f6497ec074df8b9c51dd1d','🤣',512,0,NULL,'cb\cb2100f34b87cb5999886f359f22daec4b9135c77379e8d2993118f524d2106f',512),
 (3,'fb535407d2f6497ec074df8b9c51dd1d','🎉',512,0,NULL,'57\57d0963a3e02c172206c84d205130ebb266c781463a9dae386230d67457851ed',512),
 (4,'fb535407d2f6497ec074df8b9c51dd1d','😠',512,0,NULL,'9e\9e2870b2f6821fa2a74234e3fd4d7514f1a5f32f2d19b1e84d080d9506801eed',512),
 (5,'fb535407d2f6497ec074df8b9c51dd1d','👋',512,0,NULL,'a8\a8f11a8f766db6cb248b0f386fa2d1ffcc9ff9784643be892f8d6b54e4fdcc78',512),
 (7,'fb535407d2f6497ec074df8b9c51dd1d','😔',512,0,NULL,'b6\b684655ded73c79bd431f31deee3584f9f2ee3160c252c06858dd981f1955b85',512),
 (8,'fb535407d2f6497ec074df8b9c51dd1d','🤬',512,0,NULL,'45\450e8c3b7ff45ae84a733c51a73e06415e67fd8f473d5071a759b3ad9c695487',512),
 (6,'fb535407d2f6497ec074df8b9c51dd1d','🌹',512,0,NULL,'d2\d2014de4b3df737bc60c3b28b2d1f89118e6f9708a4417d2241e7a49d25ca666',512),
 (11,'fb535407d2f6497ec074df8b9c51dd1d','☕',512,0,NULL,'07\0701588898c36b383c1b2ce917f0d50eb403317cbc9f9f8fdae9531b84c6b371',512),
 (10,'fb535407d2f6497ec074df8b9c51dd1d','🤤',512,0,NULL,'f8\f8082062b6e840db8a5100ddff73a8170d67db79330ec1ec1b11ddb79be2bdf3',512),
 (9,'fb535407d2f6497ec074df8b9c51dd1d','🎂',512,0,NULL,'51\518584e05851861a4830116bb194620ad1084fa575fd866421519229892a4ed6',512),
 (14,'fb535407d2f6497ec074df8b9c51dd1d','💬',512,0,NULL,'71\71a352b66d245f6d93b21c6492824ce6158a3a539d07b5869db1248a6d763ec7',512),
 (13,'fb535407d2f6497ec074df8b9c51dd1d','❤️',512,0,NULL,'5a\5acd33432ad4fb9217aee999bf525c261b324333cbd6cc08b795798f798c61ab',512),
 (12,'fb535407d2f6497ec074df8b9c51dd1d','😕',512,0,NULL,'69\697f78ba7b4a74c3719212484e3e2a7008ec1c1f2d5b9d9062acf3db314d79aa',512),
 (15,'fb535407d2f6497ec074df8b9c51dd1d','💦',512,0,NULL,'82\8232058d0808a51aa68acd8c463481521b0ed9df737a40fb82b03e5177adc1e4',512),
 (16,'fb535407d2f6497ec074df8b9c51dd1d','🎵',512,0,NULL,'26\2665dcdf49a47a00c3ed6159c831e178db5bad18ceaeb782e091dc87c24e1c62',512),
 (17,'fb535407d2f6497ec074df8b9c51dd1d','😅',512,0,NULL,'9f\9f20a309b97e4d53406e721b315ba269d15ee5b949dd60b6cf57678c03c4fb54',512),
 (20,'fb535407d2f6497ec074df8b9c51dd1d','🌅',512,0,NULL,'45\451bc1049232bd9af576ca722d701933c4f502d96666cfff3fee8c58df4f769a',512),
 (19,'fb535407d2f6497ec074df8b9c51dd1d','😴',512,0,NULL,'d3\d3c99970e66610302c8223f66cd56bba1ec423541281197a6668b5ed812e5168',512),
 (18,'fb535407d2f6497ec074df8b9c51dd1d','🙏',512,0,NULL,'43\43782737108fbf7b907d803ef05abe05fc380bb16fe201cffa56df9cacb66f61',512),
 (23,'fb535407d2f6497ec074df8b9c51dd1d','✍️',512,0,NULL,'46\46953d1fb0c6aec798af5e06f2b7df6b247fe2692b64dd163c798fe61a72e291',512),
 (22,'fb535407d2f6497ec074df8b9c51dd1d','😦',512,0,NULL,'9f\9fbb50668db1b21a14f4cc8b321d838286f6f3cb4b695958bae3ff2cea8041fd',512),
 (21,'fb535407d2f6497ec074df8b9c51dd1d','🤔',512,0,NULL,'e4\e4462117fd253150b57dfbf73ace18042dadbf781626e4fcf2b61892e75b7aaa',512),
 (24,'fb535407d2f6497ec074df8b9c51dd1d','😣',512,0,NULL,'79\79da380388b5d4a68b9cd34e0f474994e0889a855776ba2c5cae2a7c6c6351b0',512),
 (29,'e61fa0867031597467ccc036cc65d403','',512,1,NULL,'b0\b00e8d9df3fb5f9e8b738c0417c042b19b0f8568862fe1246f7810d1c1b3ed57',512),
 (0,'e61fa0867031597467ccc036cc65d403','✌️',512,0,NULL,'8c\8cb571f2a740a7c454c15440cb46e658663267f86f446053299caa057690df4c',512),
 (2,'e61fa0867031597467ccc036cc65d403','✋',512,0,NULL,'05\0530c68cc2f32081cde7bae0ca338b6630b15f6a0d1eafc4945e6354c30472fd',512),
 (1,'e61fa0867031597467ccc036cc65d403','☝️',512,0,NULL,'9d\9db4d3dd770a09225c84f2cdf881a43db52435fdeee488cca166674161d26fe0',512),
 (4,'e61fa0867031597467ccc036cc65d403','👇',512,0,NULL,'51\51d941232b7d03fbf7da67604dc49394f80be8673727b434f7531a4647dad81e',512),
 (5,'e61fa0867031597467ccc036cc65d403','👈',512,0,NULL,'9e\9e5dcb5ca921d1769d78061e2a38d94846f140712862cbe6138fe7c35c556a45',512),
 (3,'e61fa0867031597467ccc036cc65d403','🖖',512,0,NULL,'32\32c55c3e72173b3c84462d6739acbbe37e7d2080d0a6d384c5ac97262133f2c9',512),
 (6,'e61fa0867031597467ccc036cc65d403','👉',512,0,NULL,'ec\ec6c88e1766f79d36e6b6fe89bff83f142c0d6a657d298524e9f2a447214a897',512),
 (8,'e61fa0867031597467ccc036cc65d403','🤙',512,0,NULL,'2f\2f87617898b92c4e6c83b0b498be877bd366bd6c6dc7d7cc64fc24be76b0af8f',512),
 (7,'e61fa0867031597467ccc036cc65d403','👆',512,0,NULL,'02\024e8367e8efe3260a2c32378f59021670217b24772732d2c248535cd8e72252',512),
 (10,'e61fa0867031597467ccc036cc65d403','🤞',512,0,NULL,'06\0644e930bd87695f90a4753e4882b0ed3fd757fb9af2536565124abc62c86a16',512),
 (9,'e61fa0867031597467ccc036cc65d403','👏',512,0,NULL,'42\420780b5b89ed75744fc9cf3f9b74e3f9cd0ef8ac3d1328e0b9bc07acca3b646',512),
 (11,'e61fa0867031597467ccc036cc65d403','💪',512,0,NULL,'01\0126ff92abd327839332a614be112cccb98c345e9435c071c830dbee75e555b1',512),
 (14,'e61fa0867031597467ccc036cc65d403','🤟',512,0,NULL,'8f\8f1c419f53c099328f38ec914daab93b29e6a80c085f1eeb146e98402d20f702',512),
 (12,'e61fa0867031597467ccc036cc65d403','🙌',512,0,NULL,'90\90262401d61b42cf892c33b19a6f3a2a6cc6436e30f4cc04169dadf09e71aac3',512),
 (13,'e61fa0867031597467ccc036cc65d403','🤛',512,0,NULL,'b6\b6525d950e3ce987a296f7a2c5b2b008427247529cd57bb7b88cbd1de7fa410e',512),
 (15,'e61fa0867031597467ccc036cc65d403','🖕',512,0,NULL,'7d\7dee0f180b3346c76ac94148c2fb2452edc136db7c8210137d13cc8502c11559',512),
 (16,'e61fa0867031597467ccc036cc65d403','💅',512,0,NULL,'72\7224c1c34620b3ce8335dd9defb5cd2c322411eabef1d29cab0cdc6b4cff6be9',512),
 (17,'e61fa0867031597467ccc036cc65d403','👌',512,0,NULL,'ad\adbd6778180278671df9a6171059b6031fa64439cf6fe0d78a22c50b4e4e71b0',512),
 (19,'e61fa0867031597467ccc036cc65d403','👐',512,0,NULL,'dd\dd3869a0c5861a0e39946e983b3249b297d18bda491327cea22adbd69cf46ef1',512),
 (18,'e61fa0867031597467ccc036cc65d403','👊',512,0,NULL,'70\705042a4876f7aaee10f5beacc3c70c069e4ed9ba606a016531ecf5f531b8170',512),
 (20,'e61fa0867031597467ccc036cc65d403','🤲',512,0,NULL,'20\20da391ceb249f80985f5306a67b099069921cf57a440ec4e8594d7d21c3704b',512),
 (21,'e61fa0867031597467ccc036cc65d403','🤚',512,0,NULL,'47\47cf220426bf6aee2760d43807d0c5b602ced622b270d1b0c92ab2954723b339',512),
 (23,'e61fa0867031597467ccc036cc65d403','🖐️',512,0,NULL,'00\00e43fea5f933e5abfed6679fff0a5a1e1d2b94e9b63b7011b252e0950ba0a31',512),
 (22,'e61fa0867031597467ccc036cc65d403','✊',512,0,NULL,'c7\c7a5c3786807eae0c94a41d26979c2a3c48aa371db47ef5d298261b1c3d65d21',512),
 (25,'e61fa0867031597467ccc036cc65d403','🤘',512,0,NULL,'09\0992d5993d10d738ea2101159aa7af82da5c3aea42b130fe197f3514c81cc9ea',512),
 (24,'e61fa0867031597467ccc036cc65d403','🤜',512,0,NULL,'f4\f46fe5a9e3f39e37da854e79e67cd56f89da6637d11dbd61bff037cd6d6e77aa',512),
 (26,'e61fa0867031597467ccc036cc65d403','👎',512,0,NULL,'f8\f8b65be9a9e03555957ab709bcc064f120615a3d882ec5d78bd7f11007bda155',512),
 (27,'e61fa0867031597467ccc036cc65d403','👍',512,0,NULL,'1d\1d8d15bd18cfd76a5f8c89862ee0d8e739407b25c71cbccd3112300292e5457d',512),
 (28,'e61fa0867031597467ccc036cc65d403','👋',512,0,NULL,'2f\2f9fae603a6e97a219941fcb3a87c6a9080589a66346baf723e510d63620b0b9',512),
 (89,'cca32f5b905208b7d0f1e17f23fdc185','',512,1,NULL,'82\8259c405557456336989cfb0bcb4c293958ea1d6f92396dae9b9ecfd0a3e36b4',512),
 (2,'cca32f5b905208b7d0f1e17f23fdc185','😐',512,0,NULL,'5d\5d5c5c2a856d661906a6080e8d4803e3570b2544d91db497c2715a12a9d38b7c',512),
 (0,'cca32f5b905208b7d0f1e17f23fdc185','😧',512,0,NULL,'74\74c4ca723dacd056f3bc4e0c9b6976ef76e28d4f26e6fb37a9f0856db26959f7',512),
 (1,'cca32f5b905208b7d0f1e17f23fdc185','😌',512,0,NULL,'d5\d5229217b1d14c749c6e7678cba43bd6e78e6dfe347a2694217733ec34a912e3',512),
 (5,'cca32f5b905208b7d0f1e17f23fdc185','👺',512,0,NULL,'09\091fcba114b98da284a94c622294fb370f7488fefd7cc97ecba8a0f7c6680644',512),
 (3,'cca32f5b905208b7d0f1e17f23fdc185','😅',512,0,NULL,'dc\dcd040aed9602015a7c1772175dda4d6f28a81d72f9bc197c9f9b4b622636595',512),
 (4,'cca32f5b905208b7d0f1e17f23fdc185','😀',512,0,NULL,'df\dff918644b9f9ca512ab2b5bc4bf0df9acc2306177fe1de2dc069d5c0760064f',512),
 (7,'cca32f5b905208b7d0f1e17f23fdc185','😂',512,0,NULL,'94\94686f495609339d631feba22169e5883f06ea29a640b670651d5b041d8187c4',512),
 (8,'cca32f5b905208b7d0f1e17f23fdc185','😃',512,0,NULL,'d0\d01f9902867792f4e18be2266c8f8ca23ef6832b6dc0a4872dc0ab2501d22f48',512),
 (6,'cca32f5b905208b7d0f1e17f23fdc185','😁',512,0,NULL,'1d\1d82eed79a97b424fc068ab4ee26a8bbe9c78af3465223a04513f9e2d1b9d641',512),
 (10,'cca32f5b905208b7d0f1e17f23fdc185','😋',512,0,NULL,'a7\a75d9878ac17bdad381c663fdbd4f219248d38ba8a1e390e137def33673cb6ba',512),
 (9,'cca32f5b905208b7d0f1e17f23fdc185','😄',512,0,NULL,'ce\cedfa0b788a2d8194595b306e5b3285c94b54694f062fb09d95e362c23106a96',512),
 (11,'cca32f5b905208b7d0f1e17f23fdc185','😇',512,0,NULL,'a4\a419310b2fb7504d58893de654305cccbe79db12fa2bc1aea2a3fe1df43efce9',512),
 (14,'cca32f5b905208b7d0f1e17f23fdc185','😎',512,0,NULL,'c7\c76b3e30987d6c32dcfe5215103a92b43701fbb0a39ac948808e5398c6412434',512),
 (13,'cca32f5b905208b7d0f1e17f23fdc185','😍',512,0,NULL,'48\48ce20d29f6951819a0cb034522d3b5732c874c2c645338fe35c5d04ef52baec',512),
 (12,'cca32f5b905208b7d0f1e17f23fdc185','😉',512,0,NULL,'25\25c56a89c436628808f891ee83cdfb37b13230dc83a3eaec0d17779404f08730',512),
 (16,'cca32f5b905208b7d0f1e17f23fdc185','😏',512,0,NULL,'d3\d361c8a0138656ed2995c334a9bc86b6d671bf4e7daaeab18f30502d9193ed5a',512),
 (15,'cca32f5b905208b7d0f1e17f23fdc185','😒',512,0,NULL,'e1\e126f6e35e4cf1e9eb420dab313b3119f3e3a4ba6dc010557caea2879fc947c3',512),
 (17,'cca32f5b905208b7d0f1e17f23fdc185','😑',512,0,NULL,'9b\9b8f83c40ec895f08f649414feccd0db3b65e5907793b68081574e52f3aa36bb',512),
 (19,'cca32f5b905208b7d0f1e17f23fdc185','😞',512,0,NULL,'ba\ba5720fbb466276eb0a0f9c243db5767dee683586da7f891455253fc7e654655',512),
 (18,'cca32f5b905208b7d0f1e17f23fdc185','😓',512,0,NULL,'99\99e877185b70f0c54c9c7dc55f6f50ff11bf5be01a134bdc5cbebec6c08bfaff',512),
 (20,'cca32f5b905208b7d0f1e17f23fdc185','😟',512,0,NULL,'ea\eac366f99bc3f7831a21998d02a7ac3edf9c316bfc2ebcd2cbd007646093fd63',512),
 (22,'cca32f5b905208b7d0f1e17f23fdc185','😘',512,0,NULL,'c3\c30e9d90c49eee05c1f82049221011ff456d2e2feb18fd180362b20b68d2ced8',512),
 (21,'cca32f5b905208b7d0f1e17f23fdc185','😔',512,0,NULL,'06\0610955764356da54bdcb83ea36778162d76e30c293d19a1b83a271a44eb3812',512),
 (23,'cca32f5b905208b7d0f1e17f23fdc185','😙',512,0,NULL,'dc\dccf50d376de87d3121625009b80845ffc5a5b56666168d8a3ad2887240dc51f',512),
 (26,'cca32f5b905208b7d0f1e17f23fdc185','😬',512,0,NULL,'8c\8c4d787a04e449ffc7015b7f87169f95852991e1ed9519b1d6e0b7fb74983d77',512),
 (25,'cca32f5b905208b7d0f1e17f23fdc185','😚',512,0,NULL,'16\161d4b6acda15418a8fc21aa3872f5cb9c81fd5500b6e0fd108c11d4d2dedc2f',512),
 (24,'cca32f5b905208b7d0f1e17f23fdc185','😝',512,0,NULL,'11\116367ca1733193486e7c3e7a4ba542f6bbecee3eacf7ad805f6d456abea0f4b',512),
 (27,'cca32f5b905208b7d0f1e17f23fdc185','😛',512,0,NULL,'38\381f25f8312921dcb4f52b7db13ea20b5ce74754951adabcb626d46f12cd08c1',512),
 (29,'cca32f5b905208b7d0f1e17f23fdc185','😜',512,0,NULL,'9c\9cf6ea7a1c21e80620f77327c19f10bec37c67f4ec5a5cba49609a1c080ece4b',512),
 (28,'cca32f5b905208b7d0f1e17f23fdc185','😠',512,0,NULL,'dd\ddb943155e809b7fe756d8f27340840a02e59006a01277f2894ead7adfab537f',512),
 (32,'cca32f5b905208b7d0f1e17f23fdc185','😢',512,0,NULL,'c2\c2689c2edf480763eb7285fca9ff88e3f2185bb9c6cacc585c83b3b0c26312db',512),
 (31,'cca32f5b905208b7d0f1e17f23fdc185','🤠',512,0,NULL,'8b\8b80fc6125d36f8ee67c2bf134475f9a352161fb5e1577a3dfba38780bc2703a',512),
 (30,'cca32f5b905208b7d0f1e17f23fdc185','😡',512,0,NULL,'e1\e12b150c80b7efab8588abb0a3473c4b933d7f95fb87b7fee7a560b1cc56425b',512),
 (34,'cca32f5b905208b7d0f1e17f23fdc185','😣',512,0,NULL,'b9\b9a3abb89741ed5874b494d803fa89e6e4a7a831c2aa4fd90a3f2aeeff3959ee',512),
 (33,'cca32f5b905208b7d0f1e17f23fdc185','😫',512,0,NULL,'c4\c442a874ffe6ae4dbe181ecb718426fbaabb381d09f71acc6488ba753a6b72b2',512),
 (35,'cca32f5b905208b7d0f1e17f23fdc185','😤',512,0,NULL,'56\5671d0ee77daef24915529a580120d7a08a083bca46d3eec13fa640b2752efd6',512),
 (36,'cca32f5b905208b7d0f1e17f23fdc185','😥',512,0,NULL,'98\98ad486c0d05663780be1da14c88ca2cac9a8d04dd8ec321a4b1e487e22b43ea',512),
 (38,'cca32f5b905208b7d0f1e17f23fdc185','😪',512,0,NULL,'23\232927cf58160d89100f94bfc2a16cdb8140eecfc0281cf71c7dc1cd6de78527',512),
 (37,'cca32f5b905208b7d0f1e17f23fdc185','😦',512,0,NULL,'fc\fc1ba9f148a819d8cb80f9953c4b7f8b2a0dab03f03f50533f5b69e02a15e306',512),
 (41,'cca32f5b905208b7d0f1e17f23fdc185','😨',512,0,NULL,'30\30bc9028d85128bb3d59b9347d8a7c0f2380da1d189cb3ea2f26bf345257c1aa',512),
 (39,'cca32f5b905208b7d0f1e17f23fdc185','😭',512,0,NULL,'e9\e9b92350c2a0cbd50a22e74641cec7bc98896146db7dfeee86b98a058cb2a580',512),
 (40,'cca32f5b905208b7d0f1e17f23fdc185','😩',512,0,NULL,'51\51b7efded5e251d5e37c2a8cb88c0c94d420c9c85e796242ca418ce5cda51baa',512),
 (43,'cca32f5b905208b7d0f1e17f23fdc185','🙁',512,0,NULL,'f6\f695590115787dae543edf068b93c0e635736a9af6c614ff70132d7b0939e93e',512),
 (42,'cca32f5b905208b7d0f1e17f23fdc185','😮',512,0,NULL,'d7\d7cac877ebb186e82a23bb5d376236a077755d4503f4a037c5eb4c2296d719b6',512),
 (44,'cca32f5b905208b7d0f1e17f23fdc185','😯',512,0,NULL,'59\594a63754a25caa70b2f260377b56e3ac968a05da4663b667a7fa3a817dc5a1a',512),
 (46,'cca32f5b905208b7d0f1e17f23fdc185','🙂',512,0,NULL,'e0\e086edd8bc0ee92773b8f867f38131adbef2f2d6b0d7e350ae006ecff04c12e2',512),
 (47,'cca32f5b905208b7d0f1e17f23fdc185','😲',512,0,NULL,'0b\0b42bd6b395777b3a54ba6603c053c76a6c10607e58fab3c1a705ebb1c1a4dc1',512),
 (45,'cca32f5b905208b7d0f1e17f23fdc185','😴',512,0,NULL,'98\98342e5cce8604dca51f93ebdd068aa46c7e6eb675e394b3ec5588e7a270bc71',512),
 (50,'cca32f5b905208b7d0f1e17f23fdc185','😶',512,0,NULL,'51\51585cc939a8b0792e8830a48c692f8b0cb208663855f7cf72cb18c1062911bb',512),
 (48,'cca32f5b905208b7d0f1e17f23fdc185','😰',512,0,NULL,'f7\f7e4fb95f4fe6d294ce142a781ce81b94fb6df13129b6b46ba8161551ad069f7',512),
 (49,'cca32f5b905208b7d0f1e17f23fdc185','😳',512,0,NULL,'14\142044e1d4cf938290b2fdb9a758b0d3793e4d4623349aa69a3eb987c57deb26',512),
 (52,'cca32f5b905208b7d0f1e17f23fdc185','🙃',512,0,NULL,'2b\2b7d25ed3cb3e6026d83b9f3d9a8ab6cbae93b4ae90390b6b90e71a949164691',512),
 (51,'cca32f5b905208b7d0f1e17f23fdc185','😵',512,0,NULL,'bc\bc33bbc0724569693066d5803a43a27fba0092fe52740622d2ffe1d166c3b5a2',512),
 (53,'cca32f5b905208b7d0f1e17f23fdc185','🤔',512,0,NULL,'2b\2bd398c2608806a48de556716f484bce5a3fb2a170713a6ae44c57bb8079cd7d',512),
 (56,'cca32f5b905208b7d0f1e17f23fdc185','🤐',512,0,NULL,'70\709085ed9bc597a1c5e747de745e876c3da251a3fb1bc3cee4a8c53403b87caf',512),
 (55,'cca32f5b905208b7d0f1e17f23fdc185','🙄',512,0,NULL,'35\35bb2e2e762e5244dddcbf33dd998500e7730ad2e3b1aa48443daf032083dc62',512),
 (54,'cca32f5b905208b7d0f1e17f23fdc185','😷',512,0,NULL,'89\89768025ce8f5d957131c7131027cac66b535421dca90a132bcabe03ea9398b5',512),
 (59,'cca32f5b905208b7d0f1e17f23fdc185','🤪',512,0,NULL,'a6\a682c29769e3f8ea44bf8154dc5b641c7ac2190acc9146091d67b42e0a10ef91',512),
 (58,'cca32f5b905208b7d0f1e17f23fdc185','🤢',512,0,NULL,'72\72c125205acc1ddd48e06e22afbace300d730f64fb7fa0f1a785954654527804',512),
 (57,'cca32f5b905208b7d0f1e17f23fdc185','🤑',512,0,NULL,'ac\ac49cbee21e15355964848f392b51e94315141965d4dd6007e8afcca2f9f07e2',512),
 (61,'cca32f5b905208b7d0f1e17f23fdc185','🤥',512,0,NULL,'34\34549ab01a3e0e86b2f195109df649f94e12a0a81c0cfd203fd0eeb34a35e48c',512),
 (62,'cca32f5b905208b7d0f1e17f23fdc185','🤣',512,0,NULL,'00\0098178a14b499614cadc1610d938d71e07da283599686f70d81ee43ae9fa2da',512),
 (60,'cca32f5b905208b7d0f1e17f23fdc185','🤕',512,0,NULL,'3a\3a97f8bbdba177bab340c1e4fba3add08cc3ddda5f590a8e96e1ec39fb3bcf3b',512),
 (64,'cca32f5b905208b7d0f1e17f23fdc185','🤤',512,0,NULL,'31\31b95ccfbc7b78d58f6260afa78b795e567a8293177371e3ea2bf81a6127806e',512),
 (63,'cca32f5b905208b7d0f1e17f23fdc185','🤡',512,0,NULL,'3a\3afe5a67a56ea3e40f6f9ea8f7773ed569e28df8c79f14dd27c066da9c11e6ac',512),
 (65,'cca32f5b905208b7d0f1e17f23fdc185','🥰',512,0,NULL,'23\23abf104740c6014deb5e1b0163cfbfd4175c66c5d25f352c46a730398c205dc',512),
 (66,'cca32f5b905208b7d0f1e17f23fdc185','🤩',512,0,NULL,'16\16d053ecb2644072cc47be7d1f51b4e07f6a52beff9e4e131c0b57b6b7a67c90',512),
 (67,'cca32f5b905208b7d0f1e17f23fdc185','🤫',512,0,NULL,'17\1779eababab850b311393d1c2a1764e4cdedd15a5996d2ad7bdd49c155b07eed',512),
 (68,'cca32f5b905208b7d0f1e17f23fdc185','🥺',512,0,NULL,'e9\e9d3d9eb2bb0554d29f868f76c7cb75d5ec960d6dd22590cc73744a6c0c46288',512),
 (70,'cca32f5b905208b7d0f1e17f23fdc185','🧐',512,0,NULL,'e3\e3dc89f9520b7372b1a6386c663d464b8d077a512f4f0d725c7ea87183c39e33',512),
 (71,'cca32f5b905208b7d0f1e17f23fdc185','🥳',512,0,NULL,'8e\8e24045630af79ee5d74fca07d2a2f68e4ced49c7b5a59466b433b8eb161b23f',512),
 (69,'cca32f5b905208b7d0f1e17f23fdc185','😆',512,0,NULL,'6c\6c5807b43291ff3b7c9a893daedf7d20a99ad3d9e7cbfb86f085e33dc0692da0',512),
 (72,'cca32f5b905208b7d0f1e17f23fdc185','😱',512,0,NULL,'3d\3d7f03af6a7589eda633e0b856012ef8b93b453d1a76832f6ee4deb7e1a86470',512),
 (73,'cca32f5b905208b7d0f1e17f23fdc185','🤮',512,0,NULL,'ee\ee0e6a108c9267afcb7d747336aef6a8a519af21bd22bb46284cdd69d2506381',512),
 (74,'cca32f5b905208b7d0f1e17f23fdc185','😈',512,0,NULL,'7c\7c343539ec7f43e85ec3c6e6ee0d6a290b8dcab7f2ec455c2eb26ea6ad1aa845',512),
 (76,'cca32f5b905208b7d0f1e17f23fdc185','🤨',512,0,NULL,'fb\fb031e7d181a36c1613a3be6717e957bcae7b10aa58e56247658236b3fecdfc0',512),
 (77,'cca32f5b905208b7d0f1e17f23fdc185','🤓',512,0,NULL,'cd\cd1b757335c4e3fc7003f8b8097c7a2dc1ea20eb3c8c434915ec7a78c8cbbd99',512),
 (75,'cca32f5b905208b7d0f1e17f23fdc185','🤗',512,0,NULL,'58\582580299e057041d84439e916d88a68be283b1f0a4e6f6142bfebbe4da9cfe7',512),
 (78,'cca32f5b905208b7d0f1e17f23fdc185','🤒',512,0,NULL,'b6\b6215992993362a7770e4ae3273f913c11238a282cc414575c354ef27a539186',512),
 (79,'cca32f5b905208b7d0f1e17f23fdc185','👿',512,0,NULL,'98\986423c7bc3f52a2878df62f759a59309d8c30e4f86faf2fa9af4e14169f1918',512),
 (80,'cca32f5b905208b7d0f1e17f23fdc185','👹',512,0,NULL,'c3\c31f9b1c632a6d734532064eac589a6d346508557f6f06c70ee8ddff2297a5eb',512),
 (82,'cca32f5b905208b7d0f1e17f23fdc185','🥵',512,0,NULL,'20\20ed2c7fca8ccdf069ba42982021b8bae78e4349302d77df0c5398727670cf02',512),
 (81,'cca32f5b905208b7d0f1e17f23fdc185','🥴',512,0,NULL,'f6\f63e92f7832f49470370d0757e4245108f4f24d95eec957670bfbf9c65dcd38b',512),
 (83,'cca32f5b905208b7d0f1e17f23fdc185','☺️',512,0,NULL,'5c\5c5068e775be0a7cc0ab280430b9e79741a08c76fa3ca58da12914788335e900',512),
 (84,'cca32f5b905208b7d0f1e17f23fdc185','☹️',512,0,NULL,'62\629a952d92a5534e07dcf384908c6ec8a0e28f6c4df3f8c32f028ef8663ffe73',512),
 (85,'cca32f5b905208b7d0f1e17f23fdc185','🥶',512,0,NULL,'4c\4c50eb4ca1cbc246b9e3245d36e37ca17e98d60f42ff5125dda973685bdb01c4',512),
 (86,'cca32f5b905208b7d0f1e17f23fdc185','😗',512,0,NULL,'b6\b675eaf33f484e0cad1944e975e94ff29cbda866fc6c9d48a3d98c778e4c4bdd',512),
 (87,'cca32f5b905208b7d0f1e17f23fdc185','🤭',512,0,NULL,'94\948bc60a9e6c15fb3e27f8706b165fb80b525a18dd1bc36800503e0486918979',512),
 (88,'cca32f5b905208b7d0f1e17f23fdc185','🤧',512,0,NULL,'04\04498a99471287f5f7480d5d0a747b5657aeb387c8ef0b62f5a094d19a3d8b80',512),
 (0,'ccc89a05dc077856b57351e90697976c','',512,0,NULL,'71\71f30ecff81efb0bb9e31f2ddf9dc6b89cebce6922fd115e03a4be7629866107',512),
 (2,'ccc89a05dc077856b57351e90697976c','💯',512,0,NULL,'4c\4cfa85a980fdfecdf759fc5165dad7307c9ff1741c1c7e0c09b9a368bb8021ce',512),
 (1,'ccc89a05dc077856b57351e90697976c','❤️',512,0,NULL,'88\883c4dd515135035cb374a08903451d6c4dec0896ecc26dc734a2a643cce43d3',512),
 (3,'ccc89a05dc077856b57351e90697976c','🥳',512,0,NULL,'b1\b12551e9c0f3af759f47284338f3577ae59c6a3f24bcb2505080366ac1c815a7',512),
 (5,'ccc89a05dc077856b57351e90697976c','😪',512,0,NULL,'99\998cff9316af3387b2e25301d4238f508d83abb8307d05b55de01e61aea0120c',512),
 (6,'ccc89a05dc077856b57351e90697976c','😤',512,0,NULL,'83\8309092da364477517abe1f12d33b7dff62ebffab5f1fbbf74c368a912361db9',512),
 (4,'ccc89a05dc077856b57351e90697976c','💰',512,0,NULL,'86\862c98ba0611f90583bee31f608a15be77de5fb7ddf817acbccb53f7fdd722f4',512),
 (7,'ccc89a05dc077856b57351e90697976c','😢',512,0,NULL,'e3\e3834cd2597c8936df3f2a9956f9c57ad0d736aa9aad151eaee50252587a534d',512),
 (8,'ccc89a05dc077856b57351e90697976c','😭',512,0,NULL,'5f\5fcdef5bf9c2cec997a2f1eefc9990ba66aeaa29c55bd940b072f51723c213c8',512),
 (9,'ccc89a05dc077856b57351e90697976c','😞',512,0,NULL,'f1\f1f90597f153c393fc5df180214cda916a4db7cf52fa4cf9fdadf67134557aea',512),
 (12,'ccc89a05dc077856b57351e90697976c','🥰',512,0,NULL,'a3\a316c7578594424dcf774d8b2e75bf130557ac7efe226d60c8161caf4141278e',512),
 (11,'ccc89a05dc077856b57351e90697976c','🤩',512,0,NULL,'ed\ed21d480204a8a1b13cce19ff8955f00c90ddaf79e8bd21c1c8a83835b548f4b',512),
 (10,'ccc89a05dc077856b57351e90697976c','😱',512,0,NULL,'bd\bdeb79bc1f3c553885dd712dc342d540898cb844757532d7d82f482281aaac91',512),
 (15,'ccc89a05dc077856b57351e90697976c','😵',512,0,NULL,'d3\d3b13d6ef44b5cccec9a63fba98796a4bfad6c5a6509fa2c591919ab7ff6fa69',512),
 (13,'ccc89a05dc077856b57351e90697976c','🆗',512,0,NULL,'48\4853022dd8bbfd35f75dda75685e704b74f4a3fe54dd2aa6710003f25afbd436',512),
 (14,'ccc89a05dc077856b57351e90697976c','🙅',512,0,NULL,'b3\b354fc3cea28232a43b756519bdea4bce7741fc33c2607fb3f4c2a367a51e91e',512),
 (16,'ccc89a05dc077856b57351e90697976c','👍',512,0,NULL,'79\79370044021a806e9d4ca37301819b02b7d4994fd382a4a26853c405babaa9b3',512),
 (18,'ccc89a05dc077856b57351e90697976c','😘',512,0,NULL,'c4\c4ad4c971f37c61ff3eec5d034097bc4b2a14ecfc82c8fd54bd2573c1aba74e2',512),
 (17,'ccc89a05dc077856b57351e90697976c','😎',512,0,NULL,'16\169c329d7bacb3d1fc6533c72db04e2f88285d91989afe810128c920f5e5ede7',512),
 (19,'ccc89a05dc077856b57351e90697976c','😶',512,0,NULL,'b7\b7196ba2413927dec226d72fb996deeee39579b8293b18687d425d9dfedb1214',512),
 (20,'ccc89a05dc077856b57351e90697976c','👋',512,0,NULL,'0a\0a7244ae69c88daa00c373503e55f961ef1b4d85b70a730d904edfe427e1adc2',512),
 (21,'ccc89a05dc077856b57351e90697976c','🤕',512,0,NULL,'43\43b41cbe964e8f5f0f88bea6ff1ab15cfd8f856e498ce4698a7734a85299b6fb',512),
 (22,'ccc89a05dc077856b57351e90697976c','🤨',512,0,NULL,'c3\c3234d1b856878c07543a883a3bc249758db9a61a0499d051422d26c354090df',512),
 (23,'ccc89a05dc077856b57351e90697976c','😂',512,0,NULL,'ca\cabbc3a3167b829fdd863bb30fbada9a5a89acf0933a3b73d314e75ba0a3e0de',512);
INSERT INTO "sendLogPayloads" ("id","timestamp","contentHint","proto") VALUES (1,1649843818545,1,'r"Bl@�)ud)���بDh�PJ�\4�rP|��[�G�N�P,"��ga��϶�n�lq��9������X�fD���Ф-�M�>	w�7��w�T���M��;��M>�u��f�'),
 (2,1649843818545,1,X'12dc012202080342d5017dde2d3badff4947eec0a497644e8e55f22164ad6cd6bf4bf9015bdefb1d439702dd97a4278ac164bfe826a7e6dc3bf8ac5812a5a2fc49f40e5d703ba1d787551127fa066b2f1444400fbf9b8a54215bb3a01f35d4853934d8008a403e33acd9420fe501e4d9ddd620d9739a5de2cc22a400d89c74b0c1357aa6eef28a36b2ebfa365e6dc4c5b5ea7725b2413c7f5cf8a347035385051f1ed6df1ae3e8d976ca7ef7c9cf39628683d2cd2bf49a0f85a0b0a4bd81b02314f4d72788fdd9bfe57706e7bb6f5371f3c95cf58a1b4be86939ea7215a073'),
 (3,1649843818545,1,X'122a22020802422459e26d5f84180043dc378f4768f262e268dd7952f132b180fe3e3bfeb7772e0efb6dbf30'),
 (4,1649843818545,1,X'12c7012202080142c0014d5e23347f79932800b7522fb9446088013fe6758c082ddc2d21141aa82a8b58a76d09ccdb4e736c711f085a24813d4327bb72ae8cf923e6d399db6280a1090c29d8dd5c0ef006a96c213ba362a72d447e10544a9441757dfc757653ab4020a8d0ceab10cb1b360a323924d42ea06044c21b101b36e24be8914ef3c86c392e6cb9e2815ae6adc6ffb8446abf804408d04bf5937b5d6bb4e2fb8af5991f46b5f3de416f2d3c36692e38f26c113ff901de9f29f3a5120fda4d252f05b22b371585'),
 (5,1649843818545,1,X'12eb012202080542e401f3fb0e46206c0addb302e3461b93a96926a95f57919a8c9fa35e475d6fe5769fe915966deca61a7a8c0a02a168964c794b115c999a871537f88d10cb1f6e9116cbbe441e64fd73ef572cc36f8fc0cc74b292b615df28584b04c2f3f146ecbc465550b984c177e973fd00c0f83899f14f0b596469264399e4ca22c1649fa28f4fb4f487cf9417ba01322bb097459c6b715fe154afdeb055813500ca2309cd3da1b631a5e9ed8c8e7f49e8ce22bf306178b898ad2500a1d6e05aac81d262baeab77aca0982ddd819259b3489ed6b370ea7274b7464f4c4887e8d23e7c8d7fcb9a19732b722'),
 (6,1649843824049,1,'OBI�+�3�l������^7�x�b.�죚����ё)�ځ��YO�����4��Äf�A#�ߝ�,Ҕ���;b'),
 (7,1649843843306,1,'
L
!ТЕстовая проверка2 V�h���d1ܯAM�F�c�m��Ue3#7)�8��쒂0'),
 (8,1649843843306,1,X'12ce010ac8010a0c2b373932323033393037343510eae1ec9282301a4c0a21d0a2d095d181d182d0bed0b2d0b0d18f20d0bfd180d0bed0b2d0b5d180d0bad0b0322056886882d3e005180b0e6431dcaf414dfd46f5639a6d02cfd8556533233729bb38eae1ec92823020fee3ec9282302a360a0c2b373932323033393037343510001a2437636264613634332d383765612d343236632d616561362d3666656264616165643430633a2437636264613634332d383765612d343236632d616561362d3666656264616165643430634201ae'),
 (9,1649843844357,1,'�B�ByX���a���V��3���D�����J�د+�N��!?�nQ�f�9���!޲��''o#�%��&~f�&�ll�K��D��[k�?�}��?c8d�/��o��<�c�>8"�t1���e��8�!�{��]䃶��/W''M;m�g
x`#1�@�y�3�J��X/����<-)�>�W�`^G�Ul�I~:ˉHH��yU�I��S���/4�b'),
 (10,1649843849747,1,X'12e9033a9c021221055ed69b02f2a0027749556ff3b50d37afbc1c466fd98a7b9bf20220a0f023ab4f180022ce012faeb43db51716c7e04d9781312faedf56d8b04e48f30fe5268b84151bddf057e54356d75bc0b8943d9410049e5ce7eb8ef6f4b5b70f0eb577f21ddf63c760cd742c4fe29e5d1db16528cb40eb24a81ba08f7154098141f5018558641037170f40cd2431055340214871adad8408fa68437117fd84447da2bccfd8c538b5aed5e0d84e42a94142d6d9073e78c8ff5af566cd4fe7a1eadc14da372d880afd7a386247e0a71875a2518a557cbb7abdd50e3ec5f8a91111f3df0dcbd893c3b663b177aa4749becb91011a1e4d3def7a2a2463303664663030612d623830352d343337312d626432382d34613731376261363661386342c7011db50fd03dbffd0306e051a222fb8e85687d10f7f4c206c61abd004dcc4cfd202d8f9c5d24d97f6dc416f487cc5d50c1a17bf47286d5bd10f6059985adf3fca95706b41d023ba47ca6052e2ac299c8d54724c164085c5fd156281d58b6eeaca648f223516681a8e242248e079bae54739c8d230408f4fd85623e2892762e5246bf4d495d14af8068a2a47c46a8b3fcd8fd7853003972073bb064e47a6aeca049ca99922030208d8d6a9519bff76ea42ab4bdb20d760edc8608a80dfd5cfa368ef4220e4d5eae1d'),
 (11,1649843849748,1,X'12d5013a790a0c2b3739303435343938393339122105053251c8ac30e49407b2564cbc92548a5a5520bb10ebdcf82b347df4978126321800221e12d1578b1e667679f94c6f58cddf2cdeb14924e03cb38c5fea43a48517782a2463653536613365342d376465362d346564372d383866652d66316233363738373965353042585c6f0ca0c7de43d19c2a32cfec11883fae2ac2f66aa1facbca667a16b9e1994dca30497dfa93af323ce9919cb2105fbec75c75d61dace249deb997a3154b12941e386bc61f13ffe6f1b2d1aa4fdd31bb75c22022da30a03b');
INSERT INTO "sendLogRecipients" ("payloadId","recipientUuid","deviceId") VALUES (1,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (2,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (3,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (4,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (5,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (6,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (7,'7cbda643-87ea-426c-aea6-6febdaaed40c',1),
 (8,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (9,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (10,'5040d08a-fb3c-4689-aa9a-01179879b39c',1),
 (11,'5040d08a-fb3c-4689-aa9a-01179879b39c',1);
INSERT INTO "sendLogMessageIds" ("payloadId","messageId") VALUES (7,'ad424026-9952-47fc-829d-8174c3df63fe'),
 (8,'ad424026-9952-47fc-829d-8174c3df63fe');
INSERT INTO "preKeys" ("id","json") VALUES ('5040d08a-fb3c-4689-aa9a-01179879b39c:1','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:1","keyId":1,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BZ7N2QJDU8c32kMZePPLagM+Y1U1517RDONqzsDLM1AM","privateKey":"OFXHYb/vt8syKhYh60ZYJ1irmPDBY+FwM9tz5Rwe4W8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:2','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:2","keyId":2,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BbWifjvdQCA0l6HCYiXHoXQ1wKkUqcRjNGNWE8/MKcMN","privateKey":"CMnhEvL2UPnmMgYTQSdOTytkN+ZJvtqhpTH9EBGH0mA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:3','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:3","keyId":3,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcHUk/gzFWyWGaLyzTHWSd76Yu7K/X8EwFkgEjwB/ZZ5","privateKey":"uKRb79KHvdiDBiM1vNTmkO5LDhb67alNW1mBidKfE3Q="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:4','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:4","keyId":4,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYs5UNJ2O3c3oa4F1OSXEWvk7Hz9tyzDrBC0uKAfE7J1","privateKey":"sBlKAcERnkxP1mPN1wfd9z+bD1IiD7XvKX4/3vUUXmQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:5','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:5","keyId":5,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BW2iD3DdOssbC2os9j9B4mxJPnnR37MfzRCVgrA2oSVr","privateKey":"aEtD8kfJ2Jx0gTS50nixDWosbmK77b/oS/XIE7jPbGw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:6','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:6","keyId":6,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTnsT33s86jVfOxdpXYfYRRrvRRO1Bde+LeER8VBabl2","privateKey":"uGMUXr+DAifQJnZQFXNGNvupUvS2/zlN15gMTo0kmV4="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:7','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:7","keyId":7,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BZjtvN/jQfeicpp+QTjG6zjcRQ7SOmvQ9FoB5cTqwnwx","privateKey":"UE3AErEBtiOWRI2W7SuJVXrlzQ4RbxCZwhei0rWSoHk="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:8','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:8","keyId":8,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTBXbtwgU7SUuBisIlE+7CZIQk1nnjKc7zizEkpI5VAl","privateKey":"yLACg0/JEDo1mOw6S0oM19ZbqPnPEFkH36+tefoncHU="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:9','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:9","keyId":9,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVVGBzfpQqEYaoo2ICjWkDHrFW8ikC3IkFiiNb/cpgRK","privateKey":"oDNlTRW2hTw4NHf0d1MtLq+Musb0nG0W3uAI5oPiSFg="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:10','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:10","keyId":10,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQdetMOXAQfV4MCSGqqmsNg+310QOpik4ax7NOfEBoAw","privateKey":"wKzLh2+ANSsuSjx7LjSMIq9XUMJA2nKRCmxYv0jOeHg="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:11','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:11","keyId":11,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVOpSb/LAzuwQJ6PdxlgnWeH1bcjI0CwPCXbxhlRs4EJ","privateKey":"ICWt1O/TfMoqcQ1W9bkIk3iNRl9NGEtuqdBD8l99u3I="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:12','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:12","keyId":12,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWvwCFiCJPataupgK3OinIROgWjscUZ83gRwm3HBDkNj","privateKey":"UKLAMPCbskRykaNGbcmrK+QAhxaT8+8rI82/YopCtnw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:13','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:13","keyId":13,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSkY9Z1s023V8LAWPZ/wsozehEWCWMhLLaMFqzGATg4H","privateKey":"cLXaDec0y6UxMYiwzcsid7psvy3kzI+4TRsCTzGb1WM="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:14','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:14","keyId":14,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BRrVvpN7zmWMUY2H8z1vcDPuPfYtGoumCpA6HGSPLnJN","privateKey":"eHqM7UlBF1pdu0giK+2O1iiyseKflw2udHtBcwqKS3s="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:15','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:15","keyId":15,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bd2W1zgLo5oYZI2mQgc/+pvPi6xNcsNFBRunwSwYskwA","privateKey":"QKmAZ4S8rObq8ed/D/weEQU7cgj79al8g/z9G7r3OEw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:16','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:16","keyId":16,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BS2gW1QUjdFOHgPPWUzrRLjk6RRyd74bbtK/haqYhS1G","privateKey":"UCE9ftU8/zaa/obAvG4IUGvdqAYTBgXGy/iwVuWBw2Y="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:17','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:17","keyId":17,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUKzWWklIycA3b+xwx/yLynYsMtQgqju6AJTjY5+0g0j","privateKey":"2MmrG1xwxFoRGSZXW6wef4uoqO3fgAXKcOvjZXAz+HQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:18','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:18","keyId":18,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVNFs3swVaMR5SiSYfsQXWyxfSR9B0f80ZCmHjiqTHZg","privateKey":"0KpHnnKPGtdCMCy29Rnse9OxrJKQ5nq1FbPq7htVvVw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:19','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:19","keyId":19,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVHF26xDe1BkoTK9B8TdDmUWQFL7SLtiqFIK3uws++Zs","privateKey":"WMsYYaIz+Zvp+YcI12WADwamLwC2/i1BXHrCNj8OnEc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:20','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:20","keyId":20,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSAspnwH5A7KFmJvoHnZIm1UW2P5/bh8Wr/ATiUFMW17","privateKey":"iDwQyRfS4XRpDCKr+Es/BJgOHS0sr2f2WdthIf3Hp3o="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:21','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:21","keyId":21,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWPtWxvMqq6eNJXr+JFj8JCDUWAhjwaY6Xb7NCwEk0Vy","privateKey":"EF76dzGtPB3de7vPw4oBpTa2KYqxoXLnw7ThBC4UjXw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:22','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:22","keyId":22,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQiwi0BHqnEAJEsnFaC8AsJGjkYweXcnWbGCEg5J0bIn","privateKey":"sOh1RdlAjcrHoknNYHiS0aXDnSh3ZWTe3ab8uzJE1Go="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:23','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:23","keyId":23,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BT0oiyKV6DMEXr35QtcG2AGTHHd3imrY7Dy4M9kIVRku","privateKey":"uLx+Jvqdge4Md+vjpz7vbGXtiRQsHCI6Wiwr3QuzsG8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:24','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:24","keyId":24,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BdszYqxuV3+obKaqNAOPU38RzsRxHIzmkq2qxawppzVR","privateKey":"GCE5kGnvYFxSem2iPNbwoQAXZt7cz1Kw0G1FLBDnq3M="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:25','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:25","keyId":25,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWnsK6ooR8srTV3yegCC0I3w/n4YVXC8O0pjsxfvmSlC","privateKey":"UCkwJtwmEqNP/JCKF3n4M+U2B2cTEDSlEilXI8K04HQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:26','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:26","keyId":26,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUkjTu0t08ACRzEFsWEEix5Fo0za1Qp/5YXjS6ZiL9wT","privateKey":"AI7TeTYBhZ8T8hZGuVgE/ZORxa1wYGPMr/FJEoE3624="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:27','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:27","keyId":27,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BfJ9BW7Vb7Q+3jGG1rU7STk4rN/VhEiilnBommqV+DFY","privateKey":"ECgzM5Wq0UXEquE/Mh1hJLrqhgv3Fzmus+PAUNoGYmk="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:28','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:28","keyId":28,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQYceWx8GQflSHycDjLbfjpTUoM5hPGeNbgBzNaF+hFn","privateKey":"UDdn/uYeFUSVqG86IjAWucMsxQNwobqSiwZ4jd0a8nI="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:29','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:29","keyId":29,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUdqnafOE8JXfjDGdfmTv2RYkMulraw7s/b/me+UwXgn","privateKey":"WL3XtCRZE7mJgQbRCsmvLCxslWuGLCC2LFStUFdilk0="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:30','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:30","keyId":30,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcOwvIjYwNpeoUKY7FILFrT56wj8F6LwDD+7iQ+EpF8i","privateKey":"wCvZMSF5JZsW8LuYusU9tHGGaKejWcqjXrp7o0SXrHQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:31','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:31","keyId":31,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bc77c3y92z/ClqBI9Y+Z/E3mCKaE0RIzIrYZhHfAimJs","privateKey":"EJuL/Whaiwyx8bL/TZ7wIj8xyI7wJSjEfMBlqyWt42o="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:32','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:32","keyId":32,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQgihyyOb1pqbbrHuyjJr1BI3Wa1d9Q5zUq5sCBtNp80","privateKey":"yIAHrKrjsQoYfYsrBLYGXGtw6AE/gwRpxo/Z1Ouqt3A="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:33','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:33","keyId":33,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYiuTdvcn4gYkyV/qayzkIgxN6g+c2JiPUF2nc3jusZ5","privateKey":"YBqqtnsf+jgGrFXe9UZ4LKo3fgn3KANTSUwf+a0Ms38="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:34','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:34","keyId":34,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BfTzsW5JDmVfLk5Y0my2Baa2PAF8etQMn/YgcXdwY7I2","privateKey":"wB9PerLKqH6vYk6oh75+b/0eoGAk8amuxgplBGyWD2s="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:35','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:35","keyId":35,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSJ3Osv1YMT5ugZvRAN1GdG8tVYhOQXWtmpcMRG7dQFu","privateKey":"cEbKeJbRLZWRlgR1sRUVK+y7Mos1T7i1tsUcOkiKWVc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:36','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:36","keyId":36,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BaIgWOABGbSrPnoMHBTVROdvU+Wq7FiUuwk+vuPBgjZI","privateKey":"kOgfJU2Mi8yfs30BGr7pgzU0kZGTXbWhhcpc5ImXZVc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:37','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:37","keyId":37,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUhlvjW0kCYK3iODjutpLpkzCZYG/bk2x/cqGe9K8bFr","privateKey":"sLXe3BNoOCepXeYM069Yx2KL5m4iRqTiHHMbdO671Go="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:38','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:38","keyId":38,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bbc5qqGf8misJxwkQSQWYIpJKRW+7mYY03wiEQI9doMv","privateKey":"OKzOSKCo3SnCZByobMr4mTgssCcUqTDC/AcS+4TSEmQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:39','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:39","keyId":39,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BdCaFAl2X3Usy6rNyKikNOWyPKVkL0nC3dspZOz6hnU5","privateKey":"mJ92zdewYQc2z1m7tfaFiqPDLiNNP4LVgYVOIPY/I0U="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:40','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:40","keyId":40,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVY8yx/m83ilbA+POLA+0+P8YTEVeIyjaGH/Lkv8i3IF","privateKey":"0I6a2cuwr6dgNpAdSkQoXyG2REPELC/VE5SFakOHH2M="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:41','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:41","keyId":41,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BaRSGfQNl78H9B0zHYHo6+xYlgqdrxXRmlSRvuV2S0A4","privateKey":"AI0iu0/lWiAejM73xNXYdwbc5353aXpBMLarE//NtkM="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:42','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:42","keyId":42,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTejEXiRGmuZf41+TB9VJQ0bLAJQ9iV25oMPP3m/PRIx","privateKey":"aHhkvcl4CsOHt8TCD45k0QqgEyaEAfltxpaIVsKtk0s="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:43','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:43","keyId":43,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcgGuTczeSxfWa1vINyllyKBiKO15zxL9Sd1z1ixDKcu","privateKey":"oCEPkYlzTZla1CzOnNNhPGrr/qTY6XLLiF5vFo/K/mE="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:44','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:44","keyId":44,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BfLy4wPcFQxPz3m818Dli04YBdCzC5Bu+bIhCfr6HkI5","privateKey":"wOzRDJacnEyoz30mJERbRbSiIEVPwXKZhZ4SDHVgIXA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:45','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:45","keyId":45,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BXlkZeb3yFRiW2eOaiA1lTZeS/dCW4INV4BYfLvz4hxS","privateKey":"8MwOuft0k4bKksUzpoe1KeVL0kCDs+nY8akQ9JQ7RUY="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:46','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:46","keyId":46,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTyhix2yQ911vMM6JYy1B19dNo1zdTdfrLQgbTh9b1Mi","privateKey":"sGNFJp3DeHAwBBBfGZg8pHKK42sRCCVLbYB7O5Mjxlc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:47','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:47","keyId":47,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BXJjKteaLvrzWC71cTkLnHNvtkTE7W/Y7gUjnD1nbm1d","privateKey":"OArWbTQvqaeyfmps2D/aTcEvA9SvK4c6ynz0JG4aFU8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:48','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:48","keyId":48,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSWjwJQPJURACm7rt19RX4WQS9ZErGV2xPL5jezIXMZU","privateKey":"oCoHGwLeDQ5UkQhhfWofFB0yl/zlI/6raAujjIXgRH8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:49','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:49","keyId":49,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQ0f55V+65DCehQqMMaRpNeNCGwBXexoXTesRKOfgbYi","privateKey":"+JDGTg8NyCDeKwsuz1EwhUf+qiDNN9UBu+TkKHEbl0w="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:50','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:50","keyId":50,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQEbeKNKT+VXOANE5CJ5KIB5MfzsymExMZiQ3vb3NGND","privateKey":"4M8rrttnex6W+Itlu8zI8HHDZH3z4a41A2mTmkBk/2w="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:51','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:51","keyId":51,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSVglDmNjGKgaQI8JW6DKsQcEhMI69oell2i1IGcPdAU","privateKey":"aO8b3hMcUDbjxKEn0dg7n6OHIyXw9wiBVzExZdYgXks="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:52','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:52","keyId":52,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BW5Abe9olt5o1jN7vZjN2U8DFfeI2GPa74n+SBGQa+5j","privateKey":"OD5rRqLHkVcsHzTZHLEBhJNXjtDctwUOcI5WvHDb7l0="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:53','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:53","keyId":53,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BZ9vjTtmw5gebqMICaeBgKhM44pYSX+ThKwIlCuV4xtt","privateKey":"yA7YkiYxiFnQ66JJdHY/b0kX+8HgUUxjF6wew7wo13k="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:54','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:54","keyId":54,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BdP6PXCPhYSpE8uRFwaz/5FRAXdwiQZ9osHU3OT9mdU0","privateKey":"UIoagWdJ01GOjrdCWf1BLX2qAY+Nhv9y3WORJcVqT20="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:55','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:55","keyId":55,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTn2VF0dKJIhA/+Ls6vsB1sYJfC0BaJG0olCQQnCpwZZ","privateKey":"8AmRQEsFcCrznEjog34cKIOemwLnEgbWIpbMovtKBUQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:56','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:56","keyId":56,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BdP6g+FpmbLFqnqwlBuUSHGc3Yu1mYa9xUQ8GMfzZBky","privateKey":"gEVHagRwNQoV2GCYVF+4Ar1CvxoNtEFyzFYBhh2mbW8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:57','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:57","keyId":57,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BfBWhFPQ0QIHCs/UzQxaolrBDtvLnsrpEe1NhHp7A8o8","privateKey":"UEOylqrm2AB1t0kXqn6kK+lnPaPs3okvfnWXXwnOYmY="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:58','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:58","keyId":58,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BRw57jHP0eFHagToxU4j+WZzPOXGXleXYTvrmBSJiSZo","privateKey":"qLT2MyILPW1Z823M3hwJI3b4duBUTBfhM9d2iT13Y2w="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:59','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:59","keyId":59,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BU8tCAWEuAUBsy9SA8HzMk0L1Vid+TXzBO5QQcwuGBwd","privateKey":"QMTjCs6GSRr3gargzVniy0wJfnok6G4mB8P1lb5BOH8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:60','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:60","keyId":60,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWkyAMKih3Kfv9KK2w41QzPqMuXMH9cnonYcs9pYhjh7","privateKey":"wEg0D7Ciy6Dgt3HxzTVRxn25jWEKe5hS3pAC8Akgv2A="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:61','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:61","keyId":61,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bf3jhtzTW3iFGoVRHlfHEffP8Jc0yyP/J0SUXPs3dmFU","privateKey":"YCu+CBFBcqZi3sWTNjNG4h8nn6ldHfjxL1kHMneZmXk="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:62','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:62","keyId":62,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BdOSA4NEEuW0uGbGjVUziWXZevMLrnU0W6vrK8ynT0tS","privateKey":"6DfHTsOEWI3lCMgs4ETkjW5bwJx950s7V8vc6h1iRUA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:63','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:63","keyId":63,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWfKwkT5SFpLxZChbPhdUuR/ijlw9tK2rQvzwUZGDvd8","privateKey":"0FepEIJyaIorriuoqn+3VGun1ajwUghb1+XeY72gtG4="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:64','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:64","keyId":64,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BXWVoE7RpfoQvoXnx8UEvYSUNKGq7PFMmPLaWvBy0qZp","privateKey":"2NjTr33Cg+Lx//yKK91c0gY8lMrdAYGIB0Hu/N/Bilw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:65','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:65","keyId":65,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQFDkPToaieJS+KMw7GU7Kr9PSm8M4223+je4qY6nRVV","privateKey":"4EOUYpLOFVu1NaDdgkBmV3CDDUAr7DB50gAshgXaRFA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:66','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:66","keyId":66,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BaogbPPjzK/Q1SgjailqZhYpacBnGJlNjfe5enqEMbU/","privateKey":"+JoxpBrXjdVgf9exU3TrZQlBntrWf+VnV3Sft58x/kQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:67','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:67","keyId":67,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bc0KuxU13drYl0vmWACq+Qgzl/4ok3GX7bMCzNpDaIc/","privateKey":"iHPvPOT4I0PlzPZj5G3KEpHL6NFWjd1O+Ccb2jl6eHQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:68','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:68","keyId":68,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bb3CTzAL1DYCT3hAPaORS4fd7iW0k6jZrLyhZwGGrsxi","privateKey":"6G0F2bPv+BKaCsHQtcIPc1mq5TM5uQsoNZOEpL3DI04="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:69','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:69","keyId":69,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcpZ/BaPqjckeDlbO1spf7pOHjpcIgcJgv8K/UjbflJM","privateKey":"CNN0V9OYNyPKfdaWIo+hKi0dmQLT7UsjOO5UnZ0x6EQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:70','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:70","keyId":70,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BRszRNLYAghfmNxySXF3jgrEK75gdyh+Kc5k+75JLmFU","privateKey":"KDuRDp2mVDSdHTCF3lQnMkKDNTxLyzkwhxaKzTfXNmE="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:71','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:71","keyId":71,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BZvsnBYWX9tDw3lK4UrYCxtBwGRFelQVaivyPAYFlnkQ","privateKey":"sJjA03Nl45jnQx+DoOBS/gQRnIdnwc2OcxnMgXjkjlU="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:72','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:72","keyId":72,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcpWPYBOd9eslBdDMZH4Wv8p+zMtQQKsYUCpb+8kngo6","privateKey":"2GgqjHwbeqjWg82u+bFqxa8DBkzHAA89ea0H7169Ekg="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:73','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:73","keyId":73,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcjMlcPx1MPR3RRvYJ8Rtllsoo4sG0nsPf1Kg2YLpWBP","privateKey":"IIM8vkP/nDQL5U/fwab2p+trlVSlZ4aiPRYOulix6lU="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:74','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:74","keyId":74,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BU9h6rzzxjiZuo18i6g5i663v74Dur3AB4XfLtjgQO8h","privateKey":"8JGJqOFX9QaI5g3ilaCEOE+7ldsa+wgOvFDY6kwB02s="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:75','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:75","keyId":75,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BY0RNQLSjfrH9yydZSeqjcvk0J+SF3A4KPBkdFAhiTgF","privateKey":"eKttqamm4AtZE6g61nKUcnQRI09JhBfuua1ge/rq40I="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:76','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:76","keyId":76,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bau/V0tqtThANO47i4UhwlD1WQwOwMc0sLPRv8pb5GIk","privateKey":"0NLRvWIdjvQ8SMDFprUwZod/cx9FySWMpyroGHDsrVM="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:77','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:77","keyId":77,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BU2rjEREmNzKqyCwrqlUh5DLAPxb5OkzWWRNYVDoNdJl","privateKey":"uH0eTBdzBRIk+L1qbv2yEMNbTUpBcfk7wmAETSuQNnY="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:78','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:78","keyId":78,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTmSmcshw8+nnSstgzunAuAMfI1nkrpooGMe0XfYtbx1","privateKey":"UAeDNGSPmBDK/5QbFCmPdtACwpCSl9kzbPs90yCC/EM="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:79','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:79","keyId":79,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYSnUbbGmSYxN9Lt6e3KCHcXW+1P6/0Gd++r26lToNRG","privateKey":"yLmotfnBaiBVaW8G+509TOKLdRJqjVL5zgfkyKlSbms="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:80','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:80","keyId":80,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BcH+FrNcfu0DJExUaKEZo/nEwfcs5Wpy6CgkmZgC6zpI","privateKey":"+FvPMsUj2Ma/sdayZIc+iUjEOl60eVbGVAXpuskzGHk="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:81','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:81","keyId":81,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BbYqw5QpnYD2ng5o3kYHhZN6GWRspqX/vRsMfBJZX40n","privateKey":"UHO1R9EcuiJ+1c8bdwGJSpAn6MqrWxyjtCp6lgzZa24="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:82','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:82","keyId":82,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"Bbeicok8UhrqWZgIq+EwYsUsFiJJ53amx8JFS+jWNWps","privateKey":"uPmSxZj5tTf8i5nIOxn+hC4bxscJkyrwwhHzxelXcUE="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:83','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:83","keyId":83,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BfUnOganxzDcP9Na9B9clv/Y+A2Eq7Dne2/+PC2u3E1V","privateKey":"SOw9H7/0CrxSljVsmRMUi64rMaY6lNBW//1dClw91Hw="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:84','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:84","keyId":84,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUE3srm1ESlJ1s84fABYrZoDR8wdpMFrI/IVgDszrm0b","privateKey":"cOEtj99SX9eq7NXdg7MWnE77xaYMLDZmgtYyYRxjv0Q="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:85','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:85","keyId":85,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQphVqxdbnfEC5yn9qA7zwVU8uZI8e3CEs0urBagh08c","privateKey":"UC3FQkR8LHvbvzZstBzdSt25s9Wp79YVX+JVQBbG718="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:86','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:86","keyId":86,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQLwfg1UFH0zMNDSmYApO7lRmMO5yHmUwjpb14cZr+Rs","privateKey":"AHuqA0O1bEFwsE57EZmddZrslpOGMeDEzL0xCVUsuVA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:87','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:87","keyId":87,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUzaZQTIqY9Ny+X8zbPUfwQewsiHs0b9Wk8IYrb4RYAA","privateKey":"gKQf187jDgPkDUYFHDF7ymgDZT3p7n8XfORWCYrjQFU="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:88','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:88","keyId":88,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BQu3Whqqf+en1Li93jbIv/8K9R17SjvkeGdq1oPXc8hr","privateKey":"qFKfPoWhpw0JaBC572bdmipj8B0HgqNWZC6vochqLFQ="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:89','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:89","keyId":89,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYsW5j11vPA09vXmMQjUWu01ueZiYf1aGR2S6fyUtxx+","privateKey":"4FVuV9xBa64sDkQN7mNy9R9uHOyNzLN9UjAuWC/Uvl8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:90','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:90","keyId":90,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BZkvuJp9wiz3SplCOALuvU/gNX4Fei5JvCz0784FrrJZ","privateKey":"0GviXDV0cHjSwe7HtdZ87MW3jKdG82Vd+uj4KwdruXA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:91','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:91","keyId":91,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTHowmvLb0yiok9iK1GEeP/6KSmGAo+9S+SChJwaVYxC","privateKey":"KHwJ3/tbGVHu86HaD7An09sDgm5QMDOA0AlwAHg/0Es="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:92','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:92","keyId":92,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BTjTbK2BQkOV4Qr+60rRafifNXrpPJn9EHeXKzJ5XZ17","privateKey":"aEjjO+Lk/ub9eWgFyoHAHvMihmsMUGuX5Xo8mUopiWY="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:93','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:93","keyId":93,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYz5548trdov9KrTlJnUTY3XY+cIjVgbPLHKsE8Fj/A8","privateKey":"wMp3SUbiAITAQJPkh7RPDkmfQ/rVxojd+JBGWgbt9H4="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:94','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:94","keyId":94,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWWuhmoW18YmXvFP/er0tgQFnNnx2AR6ClAOncqngXB8","privateKey":"2I9HQOPnq+biMHiPwk1cYVkBTscUEBrB6HW0jPMI6mA="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:95','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:95","keyId":95,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BYya6bdWFLujo0ToZS9T2RLEdPQzOZ21wQevNfRARfJX","privateKey":"IKBOdfWKIpEwWR+Oyp0lmK66w9ASHVHR5XT2gy/teXc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:96','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:96","keyId":96,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BVbeomDQc/PrkQhR23LlVQ7xZqf8l2ICs676/7eP5YkZ","privateKey":"aFWHS7Bav//OKE7kq0Q1fZC8ihxwb+CUm+QrrJXXDn8="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:97','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:97","keyId":97,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BUoIO+ZmCW4pYPCYleR0hfNpVFbpj7h9Th7xqCCl+3Jk","privateKey":"qK2Txuvj1FPZ6IhUpUtUk3vcX1EcLW2orCWNEjTsHF0="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:98','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:98","keyId":98,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BXyWr5HghMNapaSEe+2QAlNaLZaVHoOJydRBBUA1bCdy","privateKey":"WP+Xyvy+QmV1ORdcjVyCsp0fdxodddXJDcKK0L5g4nc="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:99','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:99","keyId":99,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BSFVgae/iL/tUJOQpksBBCa3jB/UG/To9Ur4e997JF8x","privateKey":"ADaF69VdO6NrAsL7RgKYjOxuWVA33Ayc3d/NHHLDHF4="}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:100','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:100","keyId":100,"ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","publicKey":"BWeLOgHgt22nRuuQuQponfNwqr76Z81sG6AlOEIps0Ed","privateKey":"KNOhgvmP5xcDqCelHf0FQzXL9WF0G4uu8LT+09A+GHQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:1','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:1","keyId":1,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bau0QqxSnRt9lssgbJ/vd3tsu5iKM1QA2uPfJQ90n99J","privateKey":"6KMl7cfxiJF9gEayfKA+VFXofkbmI3pE/X+qGdKLtkk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:2','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:2","keyId":2,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BeLS3ENLP67tRFXvBh+fv6drz2F9rQcmzolFqAhzaj4O","privateKey":"UNQzl7cz6EFj1a7XWR0iPn4rTplWQLUuQrBTqlY1v18="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:3','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:3","keyId":3,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BX9fbc5x8XqW1PR3lrtxDtYjmdH87y97rZVyl+W62UsD","privateKey":"cMXFOBD+qY32kgid1wAI7jEKxJi3waY+XE1SvJZaQn4="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:4','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:4","keyId":4,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BRmH32LTtRbGTKUbyD7aJSgCISlxyjoFDUzRMMTgRwdt","privateKey":"OBmYcNwHNgScPu2WUFJeVfLYR4qEADKJ0j1ah7Yve10="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:5','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:5","keyId":5,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVteOA+mr8Kyo4IUCSlwfGyyYGt1Noo5U4CejbdM2p9/","privateKey":"yBBBSicQSPFIiOvlEqEQtyR8a+1ID0lMKDDfGclMzVo="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:6','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:6","keyId":6,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bcrwu4k5gm7/tH3xKAFCt0T3gwMsL1mEC3GCpxYwAs1Z","privateKey":"0Gd5cw6EbRZb35cKONmdL0X48DjoTgQizkWTg7AiJXY="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:7','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:7","keyId":7,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BYdrT8oxDBGwYcOfjOEeMQNtbPwrzF38YOrky1fccOJK","privateKey":"8JGe1VIEm1L0M4Wp6V+aMcVwCN7R7Wut8vyWq/9rSmo="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:8','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:8","keyId":8,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bf6Q+6z7Z8Yj49imQAzVw5XK0xQ4hZEMiAxa9N17qOYm","privateKey":"4ByyA2+MUyjCaxa/MPp/EvavDD7lVrY883BGwZizWE8="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:9','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:9","keyId":9,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BYLEZGcLvmWNJh0ib+bgYPURBmX1a1yNR22paQMhU4oN","privateKey":"OA3TmRBUnb+r0Wlw+lCnxqPWygFHJf5EbEB6y5ojZ0E="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:10','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:10","keyId":10,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BfWD6+SSc81iro5buFUqvw0Keju3VT22tHpSl+iH+xtX","privateKey":"sGJvNtgJEj1ly9HVoGdN8jFMLfoJR7uTqAs9ZKGhS0Q="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:11','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:11","keyId":11,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BTaqQiFgkIEiKqLw7eeR6XNm48TQLFck9UJeh1hm8Wx9","privateKey":"UPc2Zhc4GH7mG1TwtcfITElytRgyertIse8nEIeSrEY="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:12','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:12","keyId":12,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWoRM8pEH/WIalOKL8vhv/kS6C0QTbnfFqFbtfhfd4cS","privateKey":"WNH7L1DyNOBoxKBTgOFqHkeXxJsRWXehd8kDfa27RXs="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:13','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:13","keyId":13,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BQAgZSdMkc6pMd7drmEOe6QmouAai3wao5bPEq3aqW97","privateKey":"6BQlQQOaYcDHA3b5A8fGZGeRRtIw6YX0eM4Ui6c/L1k="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:14','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:14","keyId":14,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSpF31zOdxK0PtAnETEolV9yY1bfyjpNXio2DoFnjWM0","privateKey":"oA4qjQ2U6DCbfyA367Nsp+DxSJ91j9uHqGBp4wdo13M="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:15','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:15","keyId":15,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BeZ8btjJhQEO+McOAQ3vMS5Usrn0Ng/yknzMtsQkf2tO","privateKey":"EOPNnHVnu0n50nD3nhkfAbzo9sAMmFAdxo51JdTY5ns="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:16','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:16","keyId":16,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BTrlYtiN7hqo6GvjC9t1B8Fc7N5guPiWmuPrhXfmCtcs","privateKey":"eBczFaU7eDmZnXR3ndozSQyaTZ1vBpypYmqbT5W6sGw="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:17','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:17","keyId":17,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVHlAco2cRGH818eE/nujfNZe7WX2ZMnvm26TnuTcFAi","privateKey":"4HU4y9NEjO1EEzJKIl+chaLAAEQ5ar0MGHHKVvz8wHI="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:18','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:18","keyId":18,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BeqR00Bu1TF8oTKPjHO4vXsmqZc2TSB/eAVKPup/MqUt","privateKey":"sBR1x+T/qLa9Oi3kHoNkdmea+dpUWmqYtGzG2UUOjXk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:19','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:19","keyId":19,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BRvDwxruIV368ps7a5K/G9R00NLU7oYBob7V2B9S4nA7","privateKey":"+MmzszjC+WUFeWTTyQBjgwnKFA3bkw9mER+YGM6x+ns="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:20','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:20","keyId":20,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWd1mwwAYPOnFZpkBspHC7CZuDJ6OmGPIhQ8TTGW2bdm","privateKey":"SDtWvZknmEsdHIdFEu6yrmt3ZTMJS+8nVQ8gV8UKmmE="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:21','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:21","keyId":21,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BS6uCuq5/ZPmq1sAnuUdcZGQj6wyjbtksw1UO6F9ekwO","privateKey":"4KH1ynf6VFeo/vP+AMUllzdbmoTOyxjdUjtlvTX7okM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:22','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:22","keyId":22,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSNG8EW9RwuxR8rvcBY0T7GMIggJTJ6lXOwlEnPoUtcj","privateKey":"+HZBjxcF9GhHj3JM09CBCdmFsxA7VYocXQwct7fk+FI="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:23','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:23","keyId":23,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbQvQihlgZMjyIlZK/q9A8EcCh1Wahcu+TQruLTr1awn","privateKey":"SFU/uqkbdaVl6jEhG13NPO1Vn3BpfygPJhQ7/+YBInk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:24','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:24","keyId":24,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BUWcHQHc3aUgnr5hfbKLt/3iPPHoWBZJoDuxvu/3k1Uj","privateKey":"sHEAi+/sCdMMP0bl9nawHwTWGfq6wV5EVZwbSf0YoXY="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:25','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:25","keyId":25,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bd8tf8EF7IEd2KiAxijEUM5KzwInszsuqZEHKxwD18Ie","privateKey":"qMJ8zC5sdnpuADFQLtz6meCkfmzpkIuME/xmtVlgg1Q="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:26','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:26","keyId":26,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BS/KUY483j6WT3ZT5b9oG2Es2SZ37Y0diT50eY4CVMl3","privateKey":"YHL7S7otq3MH1kq0R59BH0fY18nhf8TENqXFIG69g00="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:27','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:27","keyId":27,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbPydDVspOrSZ7/G6FFxf48HbqASkBT8RkDoye9g5G0A","privateKey":"qER7vcCAnLXEHXrXqmR65KCdi8owrbLwFaIyiycLYUM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:28','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:28","keyId":28,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXhFu/TcW2RvcgKNrEGeRnt+n7wdfEvjlTM2gUdbz8dH","privateKey":"MPLX7M0mMfh1cuFzDg/tZr6NkQn2+sr8aGj2t9Bkx0I="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:29','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:29","keyId":29,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXgM/m5MgqdOsaq+NSnrVji7pwzIInoqVx3Bh6rcgi9P","privateKey":"IMMEXtpYwE5uQ9XcBo10sZTJuE8TdSNVrnosSDZbeVQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:30','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:30","keyId":30,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BZdeclkVBwO+zuZQCB7yW0MhjdxCvjQLBD3dXQr7WQZM","privateKey":"kL4VRTF3V2HXxNxcI3mmpf+hcznshyiXSndZQP3jzlg="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:31','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:31","keyId":31,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BYe9PHvwN9zgWdrytxbyik7S4G9YMyAaKvo7SqOb1JwT","privateKey":"kOyjKN8fDbCwNPxUkPn05CTtLqx6YZOOLbxsh3voHmM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:32','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:32","keyId":32,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWithBWX/SpbAKmmdJ/S7sC4ZjFUK4oa698mGLyKyvYT","privateKey":"YAqUiioCEIvmq4LXypd8CJkiYwPU7znO8+QvntPJ+08="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:33','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:33","keyId":33,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSb18afZoemjpsf6CVoJ9Sqbv8mi5VahSXZIrWclxyFu","privateKey":"IJ3ls0w93VkSoKUQJjJyKQY0rr3/DcNhmeW2CyA/A2U="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:34','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:34","keyId":34,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVcWt/0T9idibJcGB0oheygQt3k0VyjWraLGMMzq/kAP","privateKey":"GITq94VcFn8ZnrkIAqhraQrfL5EEav9KoMK/0Dycm08="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:35','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:35","keyId":35,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BdoIziZ6y7LIAujNu7DIsDQ87F51Zg6gAY2vWVfWvRlF","privateKey":"yPbNhWfU+6D0tqTarDDK2Zc3bJZzcrmSwyLpT+MrWWM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:36','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:36","keyId":36,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSmkZYXhHvJtl1Xe33Q4BmsfeqyJ234xo80d0VWwD/RX","privateKey":"iLpHlvjQwnnUNYnrCUvIHuTujtSKWxnAslz5sqwZJE8="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:37','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:37","keyId":37,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BaT1CJOtKIFHyFzn20ddvGqsdMXD/tVuUyePJ838ufYK","privateKey":"yKISSVggYzqnhyrfhAOUGAcfL+Rk3dfOj32EHZHHWGQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:38','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:38","keyId":38,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BZ0h2DS3n9z+gliH9cPe2O7QC9+jaf3V/bM4+E/woHMj","privateKey":"8CWl73LpeKTCQnTiexElHYNiyE7VqP8R38Hiis9L8UI="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:39','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:39","keyId":39,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWP9cbrC27FBi0KynzfPws4rluQTp7JrziW5ZdgUHYJs","privateKey":"wLD7xwHMfjIYEAuY8g+WFp4vNVnBtW4Hwwq3yDuJTHc="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:40','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:40","keyId":40,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bd4Wxf1WdbBhXF2Tu/Rc3sPyhWT8DJWVj7A0Q51CkzZ7","privateKey":"8Fbrz+XH3rYgMLKKixp4BRV/v2CEsE1Z4VkZV+9zfmM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:41','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:41","keyId":41,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXEvMwFkUOXhgJwichjI1ngwgKGUXiUMhuhvjr7mov1B","privateKey":"+I3GTBOfXMtxgrzq5qXs1/sIMKj4aodg4F7ymy8/umQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:42','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:42","keyId":42,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bd97rdS7f942q/bbmCo+XkON+i+noHjFBIx2z9//fgUE","privateKey":"+F232rPDS5tAhunF5Gcr+S5dR/lty+ysdhzXIU1EcUA="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:43','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:43","keyId":43,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWAA0DU6rONzijMS6feqOX22xmEU9FkRiT6JrFTH0qhv","privateKey":"eAb11GXCuu5ftzzo1o1Vb/tlckc2sl/NPRr9vkeyC0I="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:44','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:44","keyId":44,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BY2AGvIL4dO7zUO2ERQCsIsAO627sGJ11NGQ/efGNylr","privateKey":"+LbC8HCuje4AQmye7kt0iIDrbCXiy4VjM0HsSe8foWA="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:45','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:45","keyId":45,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BTsYyaodU3MtiTU9ayosShODAhFPvotbWbRG5+KbecUq","privateKey":"iL/dZQ/kmHj0B9KyPx16s4OnCwmm5Y/NybXjc07CS1U="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:46','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:46","keyId":46,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVU+Z3qoakz3/5V0hePtb4AGWY5wTq7psn/N7q5s7IBT","privateKey":"mGFNWKS9VYMobXicoVWM0/gcqcKs4rMI6hu/4SmLfHU="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:47','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:47","keyId":47,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXSMf1H+kpyf16Hvg/mPzmQHm9fY/+6f4NAoG9m1IJtS","privateKey":"8NMLPcjyc8BM/wZHGRcRZ3bFalgEAVeyjS4SDFaJklE="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:48','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:48","keyId":48,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BdgQjC36RhpzxzRkWknFxQ9OhvEq0QpefUn2mxXjQI8y","privateKey":"+Ou7ZStrUIJBT9IbLjXRP5+9mhS8WiSAYv81Us40YGU="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:49','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:49","keyId":49,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BRzWme6AUhXsbfwie9p7SPzcodhMpWVegp5oR0tjNBFG","privateKey":"uF7R4yiFH9qXP3fJ3ohIihgmqyGx5w+E8Zw7udYX+Wk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:50','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:50","keyId":50,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bb4DfUkcb1PFPzKOSqSfVvI1A6caM/cwlkLACziXoz9j","privateKey":"UBxKZ2FEWY77hJswQpTqguDhTGJNmrQocpFvN4xeB10="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:51','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:51","keyId":51,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BaYbhRwd/fKS8abKGZyk6MD6G2+t84lnqk87nlpqUWMw","privateKey":"AC3AD3pe7q9PbqmiBYswgJDihf9jTo8toc7+lW+SvEE="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:52','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:52","keyId":52,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BZOneZXx7s5fZLL7LhHofxgdKcZ/W6F6NdPXh4MaWx8G","privateKey":"OP0oxwZGzAdBNafkdk+OuJePmj7vo3DTo21buFyRT0o="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:53','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:53","keyId":53,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXD0Vq4fIzMxrB6kqEJtBZRu9unK7pvcOf1PQBcRhi8E","privateKey":"ADplpsD5hZqPOI/EXQ3PT8owZyxxj+/kRkxRJe52qWo="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:54','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:54","keyId":54,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BepsHG1lRpT47i1NOEo9vQgsjSPpPM97j66lrrs4Xs5o","privateKey":"OJTCaF7NAzVcuKiIjDoqv+LCExqE0C4dulfTmy1+x2g="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:55','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:55","keyId":55,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bc3IxQkF80eUa9UfnhW8CsmDVmQGYFeYq4/h4Gtn7gFq","privateKey":"SBSaCeQFxz/m2Fu6wcej+uu+8ZLjk2/rKIUj6M85L3s="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:56','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:56","keyId":56,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BaFZ+Hg6htk9Pi+Gw5jaguPkcKFElqoLqtujFMlrZ1Rh","privateKey":"oEYdpEXGUQrtvfOA0k5NGSMSsLvHfkh7dYZUhFzByko="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:57','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:57","keyId":57,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BY/LhtoDdq+H5PFE0jIym/XHL1CAKfPyE9GZFX/zolFj","privateKey":"SD3bpe9ByhY+3fvDouXX2gmRMiRRXl4Bp4Wpm/vV+FM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:58','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:58","keyId":58,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BdL4PNtQAK2SpnywqjYwRkc/kFPUYqbWmUgqOVdIuyd6","privateKey":"wLOgFVDtTSs3/2VXWfyRu4mTYZASzFdp5d6/TwYf634="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:59','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:59","keyId":59,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BfFNAAfK5sQ+bSGEmL7k5en3ASqa3xqZuF3lTq00nOUJ","privateKey":"YIZJzUE7YcopURb/6bwamp0QZdCTSuVPnPUym7L+wVs="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:60','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:60","keyId":60,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BYlq/rs4jjuqwXVKHlLMPDPNRgynx8ktzLXpNJyMdnAv","privateKey":"0N27vU+6Nvj890oZ9tJkTWo1jSN+lQDSrMdWl/j71nM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:61','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:61","keyId":61,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BcN4gDVy5e0Y70eDV09yFZRJpW5CEanIm0FhwFdDx/ld","privateKey":"6CgSLidnSoDN49CnQP+HsMknNRGMzf5H9wUxXv0As08="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:62','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:62","keyId":62,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BRmHWVhtKmyfAzYzCgOQ28Fi3iUoS8VScwLWWxD5r/Ag","privateKey":"EMAAbYe/01i3tUVr5TA8m3N/2LYkrrHeqs0L9N9N0WA="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:63','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:63","keyId":63,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXPxJSMW1unHeAWXTrXB0FzCB7DQPbVZPbTi9RWcVdkt","privateKey":"WIw9hgM3HE2MXGX0rPQ0UzXRciQaXfxU/aGAy1x3D38="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:64','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:64","keyId":64,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbNAX1BwnqiJ5rQSZFipVHRqV8z9RykK6AqASjkj2r04","privateKey":"IADiL2Hk+btC3orkgD5uuI+CqbvVQRXgg9wsET2zaEY="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:65','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:65","keyId":65,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BQmMVtdjDGPU5rBKZkRTZyZwlrvL+hf2kYhvz+2UjN0L","privateKey":"4MUhN1j7F4EXg2TAZQYHdeZu75a6EMdKJ0otHpfKPlk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:66','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:66","keyId":66,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Be0LfReqmItOC5YrXpib8BV801q/anDIS9+aPkD64CNm","privateKey":"AGe6qVPl0AuSuis04UkNy5rg/pSa3YAWdEdVmRJy/no="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:67','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:67","keyId":67,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSNSClHktDsc9qyZhACuVphV8xYVAZ4Sn38lgG4K6Xha","privateKey":"EJMTDuJdMry1ABt0VxnXTKenqKdKNPxgVO59UNzoPm0="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:68','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:68","keyId":68,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BToEa2GxlUmx2N/H+RQSywKhjS5GDQGDy/SkG9IEcDZ5","privateKey":"SKbLB/1PuN7EBTdW3rI6COl0G6xDQic6HFYjhX7PF34="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:69','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:69","keyId":69,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbBv3oE/jDugadMXgFTEu/D6K+3Jpw1GirSoBDmZts5W","privateKey":"WAJMpKzAvBGEEbVFJNBeP6dAxabZKRUrYmCeX3TaunM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:70','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:70","keyId":70,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BZQN3v8WHkFv4qskufQZdqkUCgn+CmzXI+0CDSsSZoRa","privateKey":"+KKth+V/by43kPRTfa1lCHOINDzZOgdRq4HEoH4rM0o="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:71','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:71","keyId":71,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BYrmuyQZpFGLfhoEXIVtUIyHKjFynJWmgv8Pxr/io89k","privateKey":"QKSutHQn0xfjIE3g/Spy/BeDHdqja+l6rauQySWvC2U="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:72','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:72","keyId":72,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BZ3363Be632ihJ5aIiFva2Rd+Ri9PhMImv7kJuqgdD4x","privateKey":"yCwFqHAOcvyx+I/lBazOxnmZ+UOeQvES2UvezP53zE8="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:73','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:73","keyId":73,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BSfQvkQZwetwAY40ODnV2D7tLiwwX14UP0pfvDcQWzp1","privateKey":"uO1Zx6etdhY2Yc7nW3mJzf3WKkLpjY81FpqkMhEdEns="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:74','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:74","keyId":74,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXqUfiVu9Ga2caUMAqdu5BnBoXClsp3AxF51/6i3sc4P","privateKey":"UM8Bg3Lb7Gqc5iBhgzW4duA+5NNGFdABfXTH89edz1o="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:75','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:75","keyId":75,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbdoXGErHH9NA02mu9mB7kp2Uop06aSUc4ukAxcY3qdW","privateKey":"2Dgm8WzxehJuQFXTbsc+LDxm1/v6IlP1N7DkLwJElmU="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:76','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:76","keyId":76,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbdeJ3AI8CNIq0Wsl63LMOwl5b+/w3bp5kqwYVn1KKwY","privateKey":"IMfsuFIz2kDqlpi/PL9KHORa3wrc3WRuYK7M/+CKQ3o="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:77','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:77","keyId":77,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BdQv6adl9+qBOrf5In9MjJdEo/GeQAIR5Cv/unfH9zdS","privateKey":"gMfUaQKKg8kVkZ7c3vvMpnd9iWAZHbdpZhXUTwofQE8="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:78','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:78","keyId":78,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BS1qIAxhUUsET0INdY9q+jNiVENpmOeACJXIMn3V3wg6","privateKey":"gKwl5HjcU5MmSmLCFg1bjXJFNDT5sXO6cGtUnh5tLEo="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:79','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:79","keyId":79,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BQQ7IpduMUKxtyRzyA/AiQR5WPyKmmCqJaUOVFur0FAm","privateKey":"CCkfpxc29dg4tFIf4kfi75L0DhAYYjiFVBD3bR6OykQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:80','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:80","keyId":80,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BXFP9Z5VJOM6437nH64AbfTOVKIkk/upWxQBnN/9b/kD","privateKey":"iOgYVsls4jr/GXsbbAOobnW6kzUgbgGHQg5HgfFGX2E="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:81','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:81","keyId":81,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BS7zageStAjMtgn+dUzgQV4rjvoZ/VNm7CJL1VL+flwy","privateKey":"uEVJNhUhkxEHqnGTOJ4ugTgITh53bGqXPzenQbR7qUQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:82','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:82","keyId":82,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Bd0BfaYE7bK79ghJ+5+6NfTbX5tkCgmjZ/2qBfxkJAcp","privateKey":"yE6PDimN3pvdt7HzVkZptGohoJQSJM6yZEqP9z0vMn8="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:83','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:83","keyId":83,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BUFN7tMv/8jh2egLjFxLgVNgmmyfR4Aeel0UQ1Flu+AB","privateKey":"cNFgBo1WyfSwVLIzlIvyQCbII1ESOkHFRUdbNUo/UXE="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:84','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:84","keyId":84,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BUh14XObBvT7OnXvmw7Jf3GxyVm+xALTfFZTHg+9Osom","privateKey":"YAdej4rYXvxyiS4rkW2rVhBl37Os3wTyuEEcPOjCd3w="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:85','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:85","keyId":85,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BcQDEt6Lio1Vw2kO53wjv3IkE8oRM7QnQwhdPc1wd/Bs","privateKey":"yOuDrOpZ1CCOQ2hGDZHk4tDCVc5vrPOJ7jYivwQYxU0="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:86','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:86","keyId":86,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVs74ewV0qi64ybbwrj0z7axCcQ0lmnl3kPTX4ou39c7","privateKey":"+BxmSgg5mSCrgKCLp4LA+K5ZkEtKSwEO1jbQtKckn1k="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:87','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:87","keyId":87,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Be3Nd7ob2aaelR6A2c/hpRTixAzcIqaLse5CNdn8d9pP","privateKey":"uGE3ItEYEAUNP4l3snc+JrPVDaVr9BCECdc+H3SnXE4="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:88','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:88","keyId":88,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"Be9CH/LRbimtogvKA6jv8vDBxtoSZp7d0hOrtVYe5MxM","privateKey":"kG+BZQzptgYuAGkDTIApRJyjcAVpSK5BwavrPZZ+zl4="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:89','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:89","keyId":89,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BUXqDcxOL+f6YY5+caynBiC949IMDrZy1DUioCbD2i5Z","privateKey":"YNqJxyb5i9q5xUP4TLelsWmGXpyOa+5UdZTUvmNOP2s="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:90','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:90","keyId":90,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BV2/+ID6hKgyvTB9GqKSNRzEbgLMoUs3lBAIak61olF5","privateKey":"MIg6QY8WmIhtN3pofn/jIPhtp49YTwWG8fr3JVx85k0="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:91','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:91","keyId":91,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVIMZqQdLW6/91dvtnnbgfZGk16LVuYHxYPUV+vfM+1G","privateKey":"OACejToitFfjmGJp1uw2L1nroLooyVc9RdnbNGMJzEg="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:92','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:92","keyId":92,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BTbfTuyPxjlvDCZ9gPgZeRbPRY9h1m/K106CuZ1uTQ0m","privateKey":"0IWWSmRtov/CtgLNBU/shq4xuwQr1P3tOLCGdj9PGHk="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:93','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:93","keyId":93,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BeaqJKJ1YMk1y+AEeorCXYhqOJ2Lvdm4P2HoHlZ/sisy","privateKey":"qFNnd+Qkumo0LDdUDDn1TDPGxyV7BF6mGKcgM41pWWI="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:94','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:94","keyId":94,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BdroXN78KkwwUmktAndnAFxVFQ9VOP+xuQQ9p4KM9sR6","privateKey":"WIrogx0lwEkBu6k4N5bCBveQDd7S7y6rZkxnRWVqpmU="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:95','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:95","keyId":95,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BWGDpGiS5488MjDDxJqE9cQvdK0xAUKV9chKtIn8xqNc","privateKey":"kF/R9PBOubNi6g3H0Pi1pAX+PCcoLEzqujjx+s8hNlw="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:96','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:96","keyId":96,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbHPcpDb1+DANSBcO2R6r82g7TAa+T02K4vLXmvp0zpb","privateKey":"gE+A5QM8U+3Og/Z1On5q7eSS3NMZz/+gjK1D2DGInVM="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:97','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:97","keyId":97,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BVdb2RplHMTWdg7NWQH/roj9O48iq+PGsg4y+j3LPix8","privateKey":"8DsWOuBlyPr/OrfHtsJXkoi8S304Nabfkqkqn5CRR1g="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:98','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:98","keyId":98,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbpQN9sO1RY7cLMIxZ17AF3NNZeslczvl0uv+/L7SeQ5","privateKey":"IHFq706AzAbyZP0UXIvUJVYShIE8BMtQY1GyJyjQrXs="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:99','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:99","keyId":99,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BbePuO6pU7Xv6GRZ0n8pwmvAwAMp0RZdi55GaDHDKq56","privateKey":"2Hqy8xhrZo8zl8FQC5H7ux6Aa+BxVyj5deWlddye+UQ="}'),
 ('c06df00a-b805-4371-bd28-4a717ba66a8c:100','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:100","keyId":100,"ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","publicKey":"BQ+fqSYLW9F10qt8PgjMjaIQk/yaeJsm5u+4mL2u9Fo6","privateKey":"YB0879QHOPL+9HhmnbTzSyaVRqbTMuSDIZENvgUqCWo="}');
INSERT INTO "signedPreKeys" ("id","json") VALUES ('c06df00a-b805-4371-bd28-4a717ba66a8c:1','{"id":"c06df00a-b805-4371-bd28-4a717ba66a8c:1","ourUuid":"c06df00a-b805-4371-bd28-4a717ba66a8c","keyId":1,"publicKey":"BVleLw3P2ohcTBksCoxCi3D4UUN3nA1R3e56cLjZ9HYp","privateKey":"QIg4EramScgrpWy786CNv8feFmMbCNdj8F+CQalrd2s=","created_at":1649843817281,"confirmed":true}'),
 ('5040d08a-fb3c-4689-aa9a-01179879b39c:1','{"id":"5040d08a-fb3c-4689-aa9a-01179879b39c:1","ourUuid":"5040d08a-fb3c-4689-aa9a-01179879b39c","keyId":1,"publicKey":"BYwB+otEmzX/TAHjZ5fWmlOGCsb3tACMolqbfv8cnA1z","privateKey":"iAfP5cg8G1mlk6Gp271Jbfr+h0tTTLnvAsY4YkqduHE=","created_at":1649843817314,"confirmed":true}');
DROP INDEX IF EXISTS "conversations_active";
CREATE INDEX IF NOT EXISTS "conversations_active" ON "conversations" (
	"active_at"
) WHERE "active_at" IS NOT NULL;
DROP INDEX IF EXISTS "conversations_type";
CREATE INDEX IF NOT EXISTS "conversations_type" ON "conversations" (
	"type"
) WHERE "type" IS NOT NULL;
DROP INDEX IF EXISTS "sessions_number";
CREATE INDEX IF NOT EXISTS "sessions_number" ON "sessions" (
	"conversationId"
) WHERE "conversationId" IS NOT NULL;
DROP INDEX IF EXISTS "attachment_downloads_timestamp";
CREATE INDEX IF NOT EXISTS "attachment_downloads_timestamp" ON "attachment_downloads" (
	"timestamp"
) WHERE "pending" = 0;
DROP INDEX IF EXISTS "attachment_downloads_pending";
CREATE INDEX IF NOT EXISTS "attachment_downloads_pending" ON "attachment_downloads" (
	"pending"
) WHERE "pending" != 0;
DROP INDEX IF EXISTS "stickers_recents";
CREATE INDEX IF NOT EXISTS "stickers_recents" ON "stickers" (
	"lastUsed"
) WHERE "lastUsed" IS NOT NULL;
DROP INDEX IF EXISTS "emojis_lastUsage";
CREATE INDEX IF NOT EXISTS "emojis_lastUsage" ON "emojis" (
	"lastUsage"
);
DROP INDEX IF EXISTS "conversations_e164";
CREATE INDEX IF NOT EXISTS "conversations_e164" ON "conversations" (
	"e164"
);
DROP INDEX IF EXISTS "conversations_uuid";
CREATE INDEX IF NOT EXISTS "conversations_uuid" ON "conversations" (
	"uuid"
);
DROP INDEX IF EXISTS "conversations_groupId";
CREATE INDEX IF NOT EXISTS "conversations_groupId" ON "conversations" (
	"groupId"
);
DROP INDEX IF EXISTS "jobs_timestamp";
CREATE INDEX IF NOT EXISTS "jobs_timestamp" ON "jobs" (
	"timestamp"
);
DROP INDEX IF EXISTS "reactions_unread";
CREATE INDEX IF NOT EXISTS "reactions_unread" ON "reactions" (
	"unread",
	"conversationId"
);
DROP INDEX IF EXISTS "reaction_identifier";
CREATE INDEX IF NOT EXISTS "reaction_identifier" ON "reactions" (
	"emoji",
	"targetAuthorUuid",
	"targetTimestamp"
);
DROP INDEX IF EXISTS "unprocessed_timestamp";
CREATE INDEX IF NOT EXISTS "unprocessed_timestamp" ON "unprocessed" (
	"timestamp"
);
DROP INDEX IF EXISTS "sendLogPayloadsByTimestamp";
CREATE INDEX IF NOT EXISTS "sendLogPayloadsByTimestamp" ON "sendLogPayloads" (
	"timestamp"
);
DROP INDEX IF EXISTS "sendLogRecipientsByRecipient";
CREATE INDEX IF NOT EXISTS "sendLogRecipientsByRecipient" ON "sendLogRecipients" (
	"recipientUuid",
	"deviceId"
);
DROP INDEX IF EXISTS "sendLogMessageIdsByMessage";
CREATE INDEX IF NOT EXISTS "sendLogMessageIdsByMessage" ON "sendLogMessageIds" (
	"messageId"
);
DROP INDEX IF EXISTS "storyReads_data";
CREATE INDEX IF NOT EXISTS "storyReads_data" ON "storyReads" (
	"storyReadDate",
	"authorId",
	"conversationId"
);
COMMIT;
