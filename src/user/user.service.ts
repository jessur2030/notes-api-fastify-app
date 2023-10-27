import { hashPassword } from "../utils/hash";
import prisma from "../utils/prisma";
import { createUserSchemaType } from "./user.schema";

export async function createrUser (input: createUserSchemaType){
    const {password, ...rest} = input;
    const {salt, hashPassword: hashedPassword } = hashPassword(password);
    const user = await prisma.users.create({data: {...rest, password: hashedPassword, salt}})
    console.log(user)
    return user;
} 