import {z} from "zod";
import {buildJsonSchemas} from "fastify-zod"

const userCore = {
    firstName: z.string({required_error: "First name is required", invalid_type_error: "First name must be a string"}),
    lastName: z.string({required_error: "Last name is required", invalid_type_error: "Last name must be a string"}),
    email: z.string({required_error: "Email is required", invalid_type_error: "Email must be a string"}).email(),
    username: z.string({required_error: "Username is required", invalid_type_error: "Username must be a string"}),
}

const createUserSchema = z.object({
    ...userCore,
    password: z.string({required_error: "Password is required", invalid_type_error: "Password must be a string"}),
})

const createUserResponseSchema = z.object({
    id: z.number(),
    ...userCore,
})

export type createUserSchemaType = z.infer<typeof createUserSchema>
export const {schemas: userSchemas, $ref} = buildJsonSchemas({
    createUserSchema, createUserResponseSchema
}) 