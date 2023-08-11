const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient = require("../models/patientsRegistrationModel.jsx");

const checkEmail = async (req, res) => {
  try {
    const { email, selectedOption } = req.body;

    console.log(email);
    console.log(req.body);
    if (selectedOption === "Doctor") {
      // Find user by email
      const doctor = await Doctor.findOne({ email })
        .then((val) => {
          res.send(true);
        })
        .catch((err) => {
          res.send("User not Found");
        });
    } else if (selectedOption === "Patient") {
      // Find user by email
      const Patient = await Patient.findOne({ email })
        .then((val) => {
          res.send(true);
        })
        .catch((err) => {
          res.send("User not Found");
        });
    }
  } catch (err) {
    console.error(err);
  }
};

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
        return res.status(404).json({ message: "User not found" });
      } else {
        Doctor.updateOne(
          { email: email },
          { $set: { password: newPassword } }
        ).then((val) =>
          res.status(200).json({ message: "Password updated successfully" })
        );
      }
    } else if (selectedLoginOption === "Patient") {
      // Find user by email
      const patient = await Patient.findOne({ email });

      if (!patient) {
        return res.status(404).json({ message: "User not found" });
      } else {
        Patient.updateOne(
          { email: email },
          { $set: { password: newPassword } }
        ).then((val) =>
          res.status(200).json({ message: "Password updated successfully" })
        );
      }
    }
  } catch (err) {
    console.error(err);
  }
};
module.exports = {
  resetPassword,
  checkEmail,
};
