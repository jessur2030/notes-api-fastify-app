import { FastifyReply, FastifyRequest } from "fastify";

export default async function registerUserHandler(request: FastifyRequest, reply: FastifyReply){
    return 'register user function called';
}