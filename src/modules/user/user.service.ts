import { hashPassword } from "../../utils/hash";
import prisma from "../../utils/prisma";
import { createUserSchemaType } from "./user.schema";

export async function createrUser (input: createUserSchemaType){
    const {password, ...rest} = input;
    const {salt, hashPassword: hashedPassword } = hashPassword(password);
    const user = await prisma.users.create({data: {...rest, password: hashedPassword, salt}})
    console.log(user)
    return user;
}

export async function findUserByEmail(email: string){
    const user = await prisma.users.findUnique({where: {email}})
    return user;
}

export async function findUsers(){
    const users = await prisma.users.findMany({
        select:{
            id: true,
            email: true,
            firstName: true,
            lastName: true,
            username: true,
            createdAt: true,
            updatedAt: true,
            lastLogin: true,
        }
    });
    return users;
}