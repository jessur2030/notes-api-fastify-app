import Fastify from 'fastify';
import userRautes from './modules/user/user.route';
import {userSchemas} from "./modules/user/user.schema";
const server = Fastify();
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