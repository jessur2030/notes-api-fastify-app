import { FastifyReply, FastifyRequest } from "fastify";
import { createUserSchemaType } from "./user.schema";
import { createrUser } from "./user.service";

export default async function registerUserHandler(request: FastifyRequest<{Body: createUserSchemaType}>, reply: FastifyReply){

    const body = request.body;
    console.log(body)
   try {
    const user = await createrUser(body);
    return reply.code(201).send(user)
   } catch (error) {
    console.error(error)
    return reply.code(500).send(error)
   }
}