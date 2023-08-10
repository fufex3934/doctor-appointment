const express = require("express");
const router = express.Router();
const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Login = require("../controllers/LoginController.jsx");
const { default: mongoose } = require("mongoose");
//register patients

router.post("/:id", Login.Login);
module.exports = router;
