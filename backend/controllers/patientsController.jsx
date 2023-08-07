const Patient = require('../models/patientsRegistrationModel.jsx');

//register patient
const registerPatient = async (req, res) => {
    try {
      const { fullName, email, password, birthDate } = req.body;
      const patient = new Patient({ fullName, email, password, birthDate });
      await patient.save();
      
      res.status(201).json({ message: 'Patient registered successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Failed to register Patient', error });
    }
};

module.exports = {
    registerPatient,
}