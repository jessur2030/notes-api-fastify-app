import { FastifyInstance } from "fastify";
import registerUserHandler from "./user.controller";
import { $ref } from "./user.schema";

 export default async function userRautes(server: FastifyInstance) {
    return server.post('/',
    {
     schema:{
      body: $ref("createUserSchema"),
      response:{
         201: $ref("createUserResponseSchema")
      }
     }
    }, registerUserHandler);
 }