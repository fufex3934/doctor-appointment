const Doctor = require('../models/DoctorRegistrationSchema.jsx');

//register doctor
const registerDoctor = async (req, res) => {
    const { email, password } = req.body;

    console.log(req.body);

    console.log(email, password)
    res.send(req.body)

}