const express = require('express');
const router = express.Router();
const patientController = require('../controllers/patientsController.jsx');
//register patients
router.post('/register/patients', patientController.registerPatient);

module.exports = router;