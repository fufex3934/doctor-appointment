const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient = require("../models/patientsRegistrationModel.jsx");

const resetPassword = async (req, res) => {
    try {
        const selectedLoginOption = req.params.id;
        const { email, newPassword } = req.body;

        console.log(email, oldPassword, newPassword, selectedLoginOption);
        console.log(req.body);
        if (selectedLoginOption === "Doctor") {

            // Find user by email
            const doctor = await Doctor.findOne({ email });

            if (!doctor) {
                return res.status(404).json({ message: 'User not found' });
            }
            else {

                Doctor.updateOne({ email: email }, { $set: { password: newPassword } }).then((val) => res.status(200).json({ message: 'Password updated successfully' }))
            }



        } else if (selectedLoginOption === "Patient") {
            // Find user by email
            const patient = await Patient.findOne({ email });

            if (!patient) {
                return res.status(404).json({ message: 'User not found' });
            }

            else {

                Patient.updateOne({ email: email }, { $set: { password: newPassword } }).then((val) => res.status(200).json({ message: 'Password updated successfully' }))
            }
        }
    } catch (err) {
        console.error(err);
    }
}
module.exports = {
    resetPassword,
};
