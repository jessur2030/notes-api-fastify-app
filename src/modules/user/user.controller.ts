import { FastifyReply, FastifyRequest } from "fastify";
import { createUserSchemaType,loginSchemaType } from "./user.schema";
import { createrUser,findUserByEmail } from "./user.service";
import { verifyPassword } from "../../utils/hash";
import { server } from "../../app";

export  async function registerUserHandler(request: FastifyRequest<{Body: createUserSchemaType}>, reply: FastifyReply){

    const body = request.body;
    console.log(
        {body}
    )
   try {
    const user = await createrUser(body);
    return reply.code(201).send(user)
   } catch (error) {
    console.error(error)
    return reply.code(500).send(error)
   }
}

export async function loginHandler(request: FastifyRequest<{
    Body: loginSchemaType
}>, reply: FastifyReply){

    const body = request.body;
    // find user by email
    const user = await findUserByEmail(body.email);
    console.log({user})
    if(!user){
        return reply.code(401).send({message:" Invalid email or password"})
    }
    // verify password
    const correctPaaaword = verifyPassword({
        candidatePassword: body.password,
        salt: user.salt,
        hashPassword: user.password
    })

    if(!correctPaaaword){
        return reply.code(401).send({message:" Invalid email or password"})
    }
    // generate access token & response with access token
    const {password, salt, ...rest} = user;
    return { accessToken: server.jwt.sign(rest)}
}