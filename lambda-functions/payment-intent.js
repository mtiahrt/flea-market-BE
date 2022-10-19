//node js version 14
//has function url
//AWS_IAM Auth type.  don't know how to do that yet


const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY)

exports.handler = async (event) => {
    try {
        const { amount } = JSON.parse(event.body);
        // const amount = 100;
        const paymentIntent = await stripe.paymentIntents.create(
            {
                amount,
                currency: "usd",
                payment_method_types: ["card"]
            }
        )
        return {
            statusCode: 200,
            body: JSON.stringify({paymentIntent})
        }
    } catch (error) {
        console.log({error})
        return {
            status: 400,
            body: JSON.stringify(event)
        }
    }
}