const express = require("express");
const router = express.Router();
const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const ResetPassword = require("../controllers/resetPassword.jsx");
const { default: mongoose } = require("mongoose");
//register patients

router.post("/checkEmail", ResetPassword.checkEmail);
router.post("/:id", ResetPassword.resetPassword);
module.exports = router;
