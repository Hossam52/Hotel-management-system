importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBMQmLXE6kW6WxVZvhFXd8bfNmmSzwcLlI",
  authDomain: "htask-e5ca0.firebaseapp.com",
  projectId: "htask-e5ca0",
  storageBucket: "htask-e5ca0.appspot.com",
  messagingSenderId: "405469619544",
  appId: "1:405469619544:web:157846a8a9c46fec6f712d"

});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});