const express = require("express");
const {generateUploadImageURL, generateDeleteImageURL} = require("./s3Images");
const {getAuth} = require("firebase-admin/auth");
const {getUserRoles, getProducts} = require("./server-queries");
const jwt = require("jsonwebtoken");
const router = express.Router();
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

router.get('/secureImageURL', async (req, res) => {
    const url = await generateUploadImageURL();
    res.send({url})
});

router.get('/secureImageDeleteURL', async (req, res) => {
    const publicID = req.query.publicId
    const url = await generateDeleteImageURL(publicID);
    res.send({url})
});

router.post('/user/generateAccessToken', async (req, res) => {
    const authToken = req.header('Auth-Token');
    // Validate auth token
    getAuth()
        .verifyIdToken(authToken)
        .then ( async decodedToken => {
            const roles = await getUserRoles(decodedToken.uid);
            // generate access Token
            let jwtSecretKey = process.env.JWT_SECRET_KEY;
            let data = {
                issued: Date(),
                userId: decodedToken.uid,
                roles: roles
            }
            const token = jwt.sign(data, jwtSecretKey);
            res.send(token);
        })
});

router.post('/create-checkout-session', async (req, res) => {
    function convertDollarsToCents(value) {
        value = (value + '').replace(/[^\d.-]/g, '');
        if (value && value.includes('.')) {
            value = value.substring(0, value.indexOf('.') + 3);
        }

        return value ? Math.round(parseFloat(value) * 100) : 0;
    }

    try {
        //get item name and description
        const cartItems = await getProducts(req.body);
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ["card"],
            mode: "payment",
            line_items: cartItems.map(item => {
                return {
                    price_data: {
                        currency: "usd",
                        product_data: {
                            name: item.name,
                        },
                        unit_amount: convertDollarsToCents(item.price),
                    },
                    quantity: item.quantity,
                }
            }),
            success_url: `${process.env.CHECK_OUT_RESULT_CLIENT_URL}/success.html`,
            cancel_url: `${process.env.CHECK_OUT_RESULT_CLIENT_URL}/cancel.html`,
        })
        res.json({ url: session.url })
    }
    catch (e){
        res.status(500).json({ error: e.message })
    }
});

module.exports = router;