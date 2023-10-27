import {z} from "zod";

const createUserSchema = z.object({
    fistName: z.string({required_error: "First name is required", invalid_type_error: "First name must be a string"}),
    lastName: z.string({required_error: "Last name is required", invalid_type_error: "Last name must be a string"}),
    email: z.string({required_error: "Email is required", invalid_type_error: "Email must be a string"}),
    username: z.string({required_error: "Username is required", invalid_type_error: "Username must be a string"}),
    password: z.string({required_error: "Password is required", invalid_type_error: "Password must be a string"}),
})

export type createUserSchemaType = z.infer<typeof createUserSchema>