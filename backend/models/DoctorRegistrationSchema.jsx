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
    Request:{
      type: [{
        RequesterId: {
          type: String,
        },
        Overview: {
          type:String
        },
        _id:false
      },
          
        ]
    },
    Patients: {
      type:[String]
    },
    password: { type: String },
  },
  
);

module.exports = mongoose.model("Doctor", DoctorRegistration);
