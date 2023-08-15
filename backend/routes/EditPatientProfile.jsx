const express = require("express");
const router = express.Router();
const EditPatientProfile = require("../controllers/EditPatientProfileController.jsx");
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

//register patients

router.post(
  "/profile-edit/:id",
  upload.single("profileImage"),
  EditPatientProfile.EditPatientProfile
);
module.exports = router;
