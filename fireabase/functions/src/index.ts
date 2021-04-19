import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const addDoctor = functions.https.onRequest(async (request, response) => {
    functions.logger.info("Adding doctor", { structuredData: true })

    const doctor = request.body

    const writeResult = await admin.firestore().collection('doctores').add(doctor)

    response.json({
        id: writeResult.id
    })
})

export const addCenterToDoctor = functions.https.onRequest(async (request, response) => {
    functions.logger.info("Adding center to doctor", { structuredData: true })

    const doctorId = request.query.doctorId as string
    const newCenter = request.body as HealthCenter

    const documentRef = admin.firestore().collection('doctores').doc(doctorId)
    const currentDoc = await documentRef.get()
    const data = currentDoc.data() as object

    const map = new Map(Object.entries(data))

    const centerInfo = { 'centerInfo': map.get('centerInfo') || [] }
    centerInfo['centerInfo'].push(newCenter)

    await documentRef.update(centerInfo)

    response.json({
        id: "success"
    })
})

export const addCenter = functions.https.onRequest(async (request, response) => {
    functions.logger.info("Adding center", { structuredData: true })

    const center = request.body as HealthCenter

    const writeResult = await admin.firestore().collection('centros').add(center)

    response.json({
        id: writeResult.id
    })
})

export const setCalendarToDoctor = functions.https.onRequest(async (request, response) => {
    functions.logger.info("Setting calendar to doctor", {structuredData: true})

    const doctorId = request.query.doctorId as string
    const centerId = request.query.centerId as string
    const year = request.query.year as string

    const calendar = request.body as Calendar

    const reference = admin.firestore()
    .collection('doctores')
    .doc(doctorId)
    .collection('calendars')
    .doc(centerId)
    .collection(year)
    
    calendar.days.forEach(async (day) => {
        const result  = await reference.doc(`${day.key}`).set(day);

        functions.logger.debug("Day", result)
    });

    response.json({
        success: true
    })

})