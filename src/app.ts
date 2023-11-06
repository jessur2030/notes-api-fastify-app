import Fastify, { FastifyReply, FastifyRequest } from 'fastify';
import fastifyJwt from '@fastify/jwt';
// import swagger from "@fastify/swagger";
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'
import dotenv from "dotenv";
import userRautes from './modules/user/user.route';
import {userSchemas} from "./modules/user/user.schema";
import { version } from "../package.json";
export const server = Fastify();
dotenv.config();

const PORT = parseInt(process.env.PORT || "9000", 10);
const HOST = process.env.HOST || "0.0.0.0";
const JWT_SECRET = process.env.JWT_SECRET as string


server.register(fastifyJwt, {
    secret: JWT_SECRET
})

server.decorate("authenticate", async  (request: FastifyRequest, reply: FastifyReply) => {
    try {
        await request.jwtVerify()
    } catch (error) {
        return reply.status(401).send(error)
    }
})


server.get('/healthcheck', async function (request, reply) {
return {status: 'ok'}
});

async function main(){
    for (const schema of [...userSchemas]) {
        server.addSchema(schema);
      }
 
        await server.register(fastifySwagger, {
          mode: 'dynamic',
          swagger: {
            info: {
              title: 'Note App API',
              version,
            },
          },
        })
    
        await server.register(fastifySwaggerUi, {
          routePrefix: '/docs',
        })
    
      server.register(userRautes, { prefix: '/api/users' });
    try {
        await server.listen({port: PORT, host: HOST,})
        console.log(`Server running at localhost:${PORT}`)
        
    } catch (error) {
        console.error(error)
        process.exit(1)
    }
}

main();