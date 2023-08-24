const express = require('express');
const router = express.Router();
const patientController = require('../controllers/patientsController.jsx');
//register patients
router.post('/register/patients', patientController.registerPatient);
router.post('/set-Schedule/:id', patientController.AddSchedule);

module.exports = router;