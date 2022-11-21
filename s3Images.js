const aws = require('aws-sdk');
require("dotenv").config();
const { v4: uuidv4 } = require('uuid');

const region = "us-west-2"
const bucketName = "flea-market-images"
const accessKeyId = process.env.AWS_IMAGES_ACCESS_KEY_ID;
const secretAccessKey = process.env.AWS_IMAGES_SECRET_ACCESS_KEY;

const s3 = new aws.S3({
    region,
    accessKeyId,
    secretAccessKey,
    signatureVersion: 'v4'
});

async function generateUploadImageURL() {
    const uuid = uuidv4();
    console.log(uuid)
    const params = ({
        Bucket: bucketName,
        Key: uuid,
        Expires: 60
    });
    const uploadURL = await s3.getSignedUrlPromise('putObject', params);
    return uploadURL;
}

async function generateDeleteImageURL(publicId) {
    const params = ({
        Bucket: bucketName,
        Key: publicId,
        Expires: 60
    });
    const deleteURL = await s3.getSignedUrlPromise('deleteObject', params);
    return deleteURL;
}


module.exports = {
    generateUploadImageURL, generateDeleteImageURL
}