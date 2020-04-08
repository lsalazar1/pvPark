const axios = require('axios');
const assert=require('assert');

const baseURI = "https://blooming-mountain-10766.herokuapp.com/";

const successCode = 200;

const config = {
    headers: {
        'Content-Type': 'application/json'
    }
}

const registerData = [
    {
        "username": "orange_guy10",
        "password": "ackabacka95",
        "email": "dtrump@pvamu.edu",
        "name": "Donald Trump",
        "expected": 200
    },
    {
        "username": "uncle_joe2005",
        "password": "ackabacka95",
        "email": "jbiden@pvamu.edu",
        "name": "Joe Biden",
        "expected": 200
    }
]

// Testing if backend is connected
axios.get(baseURI)
    .then(res => {
        assert.deepEqual(res.status, successCode, "Not connected right");
        console.log('Backend is connected...');
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

//  GET api/srcollins
axios.get(baseURI+"api/srcollins")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "srcollins", `Expected name to be srcollins but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/srcollins works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// GET api/newscience
axios.get(baseURI+"api/newscience")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "newscience", `Expected name to be newscience but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/newscience works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// GET api/businessag
axios.get(baseURI+"api/businessag")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "businessag", `Expected name to be businessag but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/businessag works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// GET api/msc
axios.get(baseURI+"api/msc")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, 'memorial student center', `Expected name to be msc but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/msc works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

/** 
** This for-loop wil iterate through the registerData JSON and automatically 
** register each user through the "api/users" endpoint.
*/
for (let i = 0; i < registerData.length; i++) {

    // Destructure each key from JSON registerData
    let {username, name, password, email, expected} = registerData[i];
    let body = JSON.stringify({username, name, password, email});

    // Use axios to make an HTTP POST request with the body and config settings
    axios.post(baseURI + 'api/users', body, config)
        .then(res => {
            let responseStatus = res.status;

            assert.deepEqual(responseStatus, expected, `Expected ${expected} but received ${responseStatus}`);
            console.log(`api/users... Test Case [${i}] passing`);
        })
        .catch(err => {
            console.error(err.message + `... Failing at [${i}]`);
            exit(1);
        })  
}