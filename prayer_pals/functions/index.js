const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.onGroupPrayerCreated = functions.firestore
    .document("/groups/{groupId}/groupPrayers/{commentId}")
    .onCreate((snapshot, context) => {
      const prayerId = context.params.groupId;
      console.log("Group Got A New Prayer: " + prayerId);

      const prayerTitle = snapshot.get("title");

      const titleString = "Prayer pals - Group Prayer Created";
      const bodyString = "Group Prayer Created\""+prayerTitle+"\"";
      const topicString = prayerId + "groupPrayerCreated";
      const payload = {
        notification: {
          title: titleString,
          body: bodyString,
        },
        android: {
          data: {
            id: prayerId,
            type: "groupPrayer",
            title: titleString,
            body: bodyString,
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "priority": "high",
          },
        },
        data: {
          id: prayerId,
          type: "groupPrayer",
          title: titleString,
          body: bodyString,
        },
        topic: topicString,
      };
      console.log("PN: For Group Prayer: " + prayerId + " - " + bodyString);
      admin.messaging().send(payload);
    }
    );
