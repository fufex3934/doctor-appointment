const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient = require("../models/patientsRegistrationModel.jsx");

const checkEmail = async (req, res) => {
  try {
    const { email, selectedOption } = req.body;

    console.log(email);
    console.log(req.body);
    if (selectedOption === "Doctor") {
      // Find user by email
      await Doctor.findOne({ email })
        .then((val) => {
          if (val!== null) {
            res.send(true);
            console.log(true, val);
          } else {
            res.send(false);
            console.log(false);
          }
        })
        .catch((err) => {
          console.log(false);
          res.send("User not Found");
        });
    } else if (selectedOption === "Patient") {
      // Find user by email
      await Patient.findOne({ email })
        .then((val) => {
          if (val!== null) {
            res.send(true);
            console.log(true, val);
          } else {
            res.send(false);
            console.log(false);
          }
        })
        .catch((err) => {
          res.send("User not Found");
          console.log(false);
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

    console.log(email, newPassword, selectedLoginOption);
    console.log(req.body);
    if (selectedLoginOption === "Doctor") {
      // Find user by email

      Doctor.updateOne({ email: email }, { $set: { password: newPassword } })
        .then((val) => {
          res.send(true);
          console.log(val);
        })
        .catch((err) => {
          res.send(false);
          console.log(false);
        });
    } else if (selectedLoginOption === "Patient") {
      // Find user by email

      Patient.updateOne({ email: email }, { $set: { password: newPassword } })
        .then((val) => {
          res.send(true);
          console.log(val);
        })
        .catch((err) => {
          res.send("User not Found");
          console.log(false);
        });
    }
  } catch (err) {
    res.send("User not Found");
    console.log(false);
  }
};
module.exports = {
  resetPassword,
  checkEmail,
};
