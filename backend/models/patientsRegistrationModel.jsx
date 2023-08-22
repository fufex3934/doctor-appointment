const mongoose = require("mongoose");

const patientSchema = mongoose.Schema(
  {
    _id: mongoose.Types.ObjectId,
    fullName: { type: String },
    email: { type: String },
    birthDate: { type: Date },
    password: { type: String },
    profileImage: { type: String },
    Age: { type: Number },
    Gender: { type: String },
    DOB: { type: String },
    Fathers_Name: { type: String },
    Mothers_Name: { type: String },
    Blood_Type: { type: String },
    weight: { type: String },
    Height: { type: String },
    Alergy: { type: String },
    place: { type: String },
    phone: { type: Number },
    Alt_phone: { type: String },
    Schedule: {
      type: [
        {
          doctorId: {
          type:String,
          },
          Time_Date: {
            type:String
          },
          _id:false
      }
    ]}
  },
  {
    collection: "Patient"
  }

);

module.exports = mongoose.model("Patient", patientSchema);
