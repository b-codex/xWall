const express = require('express')
const mongoose = require('mongoose')
const fs = require('fs')
const url = require('url')
const queryString = require('querystring')

const app = express()

const log = console.log
var port = process.env.PORT || 6969

app.use(express.static(__dirname))
app.use(express.json())
mongoose.connect('mongodb://localhost:27017/test', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).catch(err => log(err.message))

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function () {
    log('we\'re connected')
});

const userSchema = mongoose.Schema({
    fullname: String,
    username: String,
    password: String,
})
const User = mongoose.model('User', userSchema, "Users")

app.get("/", function (req, res) {
    res.send({
        'status': 200
    })
})

app.get('/movies', (req, res) => {
    fs.readFile(__dirname + '/' + 'movies.json', 'utf8', (err, data) => {
        res.end(data)
    })
})

app.get('/images', (req, res) => {
    res.sendFile(__dirname + '/images/' + req.query.image + '.jpeg')
})

app.get('/login', (req, res) => {
    var username = req.query.username
    var password = req.query.password
    db.collection('Users').findOne({
        username: username
    }, (err, r) => {
        if (r) {
            if (r.username == username && r.password == password) {
                res.json({
                    'status': ''
                })
            } else {
                res.json({
                    'status': 'Either Username Or Password Is Incorrect. Try Again.'
                })
            }
        } else {
            res.json({
                'status': 'No Such Account Exists. Please Proceed To Register Page To Create An Account.'
            })
        }
    })
})

app.post('/register', (req, res) => {
    var x = req.query.fullname
    const newUser = new User({
        fullname: req.query.fullname,
        username: req.query.username,
        password: req.query.password
    })
    log(newUser.fullname)
    db.collection('Users').findOne({
        username: newUser.username
    }, (err, r) => {
        if (r) {
            if (r.username == newUser.username) {
                // res.status(200)
                res.json({
                    "status": "Username Already Exists. Please Try A Different Username Or Proceed To Login Page."
                })
            }
        } else {
            newUser.save((err, result) => {
                if (err) log(err.message)
                // log('user created')
                res.send({
                    'status': '',
                })
            })
        }
    })
})

app.listen(port, () => {
    console.log("Listening On Port " + port);
})