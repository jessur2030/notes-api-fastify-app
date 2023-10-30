import { FastifyInstance } from "fastify";
import {registerUserHandler, loginHandler} from "./user.controller";
import { $ref } from "./user.schema";

 export default async function userRautes(server: FastifyInstance) {
    server.post('/',
    {
     schema:{
      body: $ref("createUserSchema"),
      response:{
         201: $ref("createUserResponseSchema")
      }
     }
    }, registerUserHandler);

    server.post('/login', {
      schema:{
         body: $ref("loginSchema"),
         response:{
            200: $ref("loginResponseSchema")
         }
      }
    },
      loginHandler
    );
    
 }