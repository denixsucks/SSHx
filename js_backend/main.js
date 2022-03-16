const express = require('express')
const router = express.Router()
const multer = require('multer')

const BASE_URL = '/api/v1'


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "./db/events/covers")
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + "--" + file.originalname)
    },
})

const fileFilter = (req, file, cb) => {
    if (file.mimetype == "image/jpeg" || file.mimetype == "images/png") {
        cb(null, true)
    } else {
        cb(null, false)
    }
}

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 6,
    },
    fileFilter: fileFilter
})

router.route(BASE_URL + '/events/create').post(upload.single("img"), async(req, res) => {
    console.log(req.file);
    const response = {
        message: "Image mis à jour"
    }
    return res.status('200').send(response)
})

module.exports = router
