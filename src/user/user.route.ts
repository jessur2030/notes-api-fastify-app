import { FastifyInstance } from "fastify";
import registerUserHandler from "./user.controller";

 export default async function userRautes(server: FastifyInstance) {
    return server.post('/', registerUserHandler);
 }