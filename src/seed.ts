import { PrismaClient } from "@prisma/client"

const prisma = new PrismaClient()

const main = async () => {
	console.log("It started seeding")
}

main().catch(e => console.error(e)).finally(async () => {
	await prisma.$disconnect()
})