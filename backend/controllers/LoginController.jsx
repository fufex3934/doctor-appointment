const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient = require("../models/patientsRegistrationModel.jsx");

const Login = async (req, res) => {
  try {
    const selectedLoginOption = req.params.id;
    const { email, password } = req.body;

    // console.log(email, password, selectedLoginOption);
    // console.log(req.body);
    if (selectedLoginOption === "Doctor") {
      await Doctor.findOne({ email: email, password: password })
        .then((val) => {
          console.log(
            "email",
            email,
            "password",
            password,
            " returned value ",
            val
          );
          if (val.length !==null) {
            res.send(true);
          } else {
            res.send(false);
          }
        })
        .catch((err) => console.error(err));
    } else if (selectedLoginOption === "Patient") {
      await Patient.findOne({ email: email, password: password })
        .then((val) => {
          console.log(
            "email",
            email,
            "password",
            password,
            " returned value ",
            val
          );
          if (val !== null) {
            res.send(true);
            console.log(val);
          } else {
            res.send(false);
          }
        })
        .catch((err) => console.error(err));
    }
  } catch (err) {
    console.error(err);
  }
};

module.exports = {
  Login,
};
