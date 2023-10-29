import Fastify from 'fastify';
import fastifyJwt from '@fastify/jwt';
const fastifyEnv = require('@fastify/env')
import userRautes from './modules/user/user.route';
import {userSchemas} from "./modules/user/user.schema";
const server = Fastify();

const schema = {
    type: 'object',
    required: ['PORT', 'JWT_SECRET'],
    properties: {
        PORT: {
            type: 'string',
            default: 9000
        },
        JWT_SECRET: {
            type: 'string',
            default: 'supersecret'
        }
    }
  }

  const options = {
    confKey: 'config',
    schema,
    dotenv: true,
    data: process.env
  }

server.register(fastifyEnv, options)
// register fastify/jwt
server.register(fastifyJwt, {
    secret: process.env.JWT_SECRET as string
})

const PORT = process.env.PORT || 9000;

server.get('/healthcheck', async function (request, reply) {
return {status: 'ok'}
});

async function main(){

    for (const schema of userSchemas) {
        server.addSchema(schema)
    }

    server.register(userRautes, {prefix: '/api/users'});
    try {
        await server.listen(PORT, '0.0.0.0')
        console.log(`Server running at localhost:${PORT}`)
        
    } catch (error) {
        console.error(error)
        process.exit(1)
    }
}

main();