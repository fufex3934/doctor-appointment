const express = require("express");
const router = express.Router();
const EditDoctorProfile = require("../controllers/EditDoctorProfileController.jsx");
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

//register patients

router.post(
  "/profile-edit/:id",
  upload.fields([
      { name: 'profileImage', maxCount: 1 },
      { name: 'idImage', maxCount: 1 },
    { name: 'licensePdf', maxCount: 1 },
  ]),
  EditDoctorProfile.EditDoctorProfile
);
module.exports = router;
