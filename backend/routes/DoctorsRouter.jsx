const express = require("express");
const router = express.Router();
const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const { default: mongoose } = require("mongoose");
//register patients
router.post("/RegisterDoctor", async (req, res) => {
  const {
    fullname,
    specialization,
    experience,
    email,
    loc_lat,
    loc_long,
    password,
  } = req.body;

  console.log(req.body);

  // TODO: add hashing functionality for password security ||encrypt the password
  Doctor_data = new Doctor({
    _id: new mongoose.Types.ObjectId(),
    fullName: fullname,
    specialization: specialization,
    Experience: experience,
    email: email,
    Location: {
      latitude: loc_lat,
      longitude: loc_long,
    },
    password: password,
  });

  await Doctor_data.save()
    .then((val) => {
      res.send("successfull");
      console.log(val);
    })
    .catch((err) => console.log(err));
});

module.exports = router;
