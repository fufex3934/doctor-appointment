const mongoose = require("mongoose");

const DoctorRegistration = mongoose.Schema(
  {
    _id: mongoose.Types.ObjectId,
    fullName: { type: String },
    specialization: {
      type: String,
    },
    Experience: {
      type: Number,
    },
    email: { type: String },
    Location: {
      type: {
        latitude: Number,
        longitude: Number,
      },
      _id: false,
    },
    password: { type: String },
  },
  
);

module.exports = mongoose.model("Doctor", DoctorRegistration);
