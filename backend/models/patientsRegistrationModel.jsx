const mongoose = require('mongoose');

const patientSchema = mongoose.Schema({
<<<<<<< HEAD
    fullName:{type:String,required:true},
    email:{type:String,required:true},
    birthDate:{type:Date,required:true},
    password:{type:String,required:true},
=======
    _id: mongoose.Types.ObjectId,
    fullName: { type: String, required: true },
    email: { type: String, required: true },
    birthDate: { type: String, required: true },
    password: { type: String, required: true },
}, {
    collection: "Patient"
>>>>>>> 9241e799493a8c5a8fd685c97d0629e02583d124
});

module.exports = mongoose.model('Patient', patientSchema);