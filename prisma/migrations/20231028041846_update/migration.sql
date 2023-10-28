/*
  Warnings:

  - The primary key for the `Attachments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `attachmentId` on the `Attachments` table. All the data in the column will be lost.
  - The primary key for the `Categories` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `categoryId` on the `Categories` table. All the data in the column will be lost.
  - The primary key for the `Collaborators` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `collaboratorId` on the `Collaborators` table. All the data in the column will be lost.
  - The primary key for the `Folders` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `folderId` on the `Folders` table. All the data in the column will be lost.
  - The primary key for the `Notes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `noteId` on the `Notes` table. All the data in the column will be lost.
  - The primary key for the `Reminders` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `reminderId` on the `Reminders` table. All the data in the column will be lost.
  - The primary key for the `Revision_History` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `revisionId` on the `Revision_History` table. All the data in the column will be lost.
  - The primary key for the `Users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `userId` on the `Users` table. All the data in the column will be lost.
  - Added the required column `id` to the `Attachments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Categories` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Collaborators` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Folders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Notes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Reminders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Revision_History` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Attachments` DROP FOREIGN KEY `Attachments_noteId_fkey`;

-- DropForeignKey
ALTER TABLE `Categories` DROP FOREIGN KEY `Categories_userId_fkey`;

-- DropForeignKey
ALTER TABLE `Collaborators` DROP FOREIGN KEY `Collaborators_noteId_fkey`;

-- DropForeignKey
ALTER TABLE `Collaborators` DROP FOREIGN KEY `Collaborators_userId_fkey`;

-- DropForeignKey
ALTER TABLE `Folders` DROP FOREIGN KEY `Folders_parentFolderId_fkey`;

-- DropForeignKey
ALTER TABLE `Folders` DROP FOREIGN KEY `Folders_userId_fkey`;

-- DropForeignKey
ALTER TABLE `Note_Categories` DROP FOREIGN KEY `Note_Categories_categoryId_fkey`;

-- DropForeignKey
ALTER TABLE `Note_Categories` DROP FOREIGN KEY `Note_Categories_noteId_fkey`;

-- DropForeignKey
ALTER TABLE `Notes` DROP FOREIGN KEY `Notes_folderId_fkey`;

-- DropForeignKey
ALTER TABLE `Notes` DROP FOREIGN KEY `Notes_userId_fkey`;

-- DropForeignKey
ALTER TABLE `Reminders` DROP FOREIGN KEY `Reminders_noteId_fkey`;

-- DropForeignKey
ALTER TABLE `Revision_History` DROP FOREIGN KEY `Revision_History_noteId_fkey`;

-- AlterTable
ALTER TABLE `Attachments` DROP PRIMARY KEY,
    DROP COLUMN `attachmentId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Categories` DROP PRIMARY KEY,
    DROP COLUMN `categoryId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Collaborators` DROP PRIMARY KEY,
    DROP COLUMN `collaboratorId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Folders` DROP PRIMARY KEY,
    DROP COLUMN `folderId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Notes` DROP PRIMARY KEY,
    DROP COLUMN `noteId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Reminders` DROP PRIMARY KEY,
    DROP COLUMN `reminderId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Revision_History` DROP PRIMARY KEY,
    DROP COLUMN `revisionId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Users` DROP PRIMARY KEY,
    DROP COLUMN `userId`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AddForeignKey
ALTER TABLE `Folders` ADD CONSTRAINT `Folders_parentFolderId_fkey` FOREIGN KEY (`parentFolderId`) REFERENCES `Folders`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Folders` ADD CONSTRAINT `Folders_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notes` ADD CONSTRAINT `Notes_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notes` ADD CONSTRAINT `Notes_folderId_fkey` FOREIGN KEY (`folderId`) REFERENCES `Folders`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Categories` ADD CONSTRAINT `Categories_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Note_Categories` ADD CONSTRAINT `Note_Categories_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Note_Categories` ADD CONSTRAINT `Note_Categories_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Categories`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attachments` ADD CONSTRAINT `Attachments_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reminders` ADD CONSTRAINT `Reminders_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Collaborators` ADD CONSTRAINT `Collaborators_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Collaborators` ADD CONSTRAINT `Collaborators_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Revision_History` ADD CONSTRAINT `Revision_History_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
