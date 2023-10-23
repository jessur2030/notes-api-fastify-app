-- CreateTable
CREATE TABLE `Users` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `passwordHash` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `lastLogin` DATETIME(3) NULL,

    UNIQUE INDEX `Users_username_key`(`username`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Folders` (
    `folderId` INTEGER NOT NULL AUTO_INCREMENT,
    `parentFolderId` INTEGER NULL,
    `userId` INTEGER NULL,
    `folderName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`folderId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notes` (
    `noteId` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NULL,
    `folderId` INTEGER NULL,
    `title` VARCHAR(191) NULL,
    `content` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `isFavorite` BOOLEAN NOT NULL DEFAULT false,
    `isArchived` BOOLEAN NOT NULL DEFAULT false,
    `archivedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`noteId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Categories` (
    `categoryId` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `userId` INTEGER NULL,

    PRIMARY KEY (`categoryId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Note_Categories` (
    `noteId` INTEGER NOT NULL,
    `categoryId` INTEGER NOT NULL,

    PRIMARY KEY (`noteId`, `categoryId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Attachments` (
    `attachmentId` INTEGER NOT NULL AUTO_INCREMENT,
    `noteId` INTEGER NOT NULL,
    `attachmentType` VARCHAR(191) NULL,
    `attachmentData` LONGBLOB NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`attachmentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reminders` (
    `reminderId` INTEGER NOT NULL AUTO_INCREMENT,
    `noteId` INTEGER NOT NULL,
    `reminderTime` DATETIME(3) NOT NULL,
    `sent` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`reminderId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Collaborators` (
    `collaboratorId` INTEGER NOT NULL AUTO_INCREMENT,
    `noteId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `permissionLevel` ENUM('READ', 'WRITE', 'ADMIN') NOT NULL DEFAULT 'READ',

    UNIQUE INDEX `Collaborators_noteId_userId_key`(`noteId`, `userId`),
    PRIMARY KEY (`collaboratorId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Revision_History` (
    `revisionId` INTEGER NOT NULL AUTO_INCREMENT,
    `noteId` INTEGER NOT NULL,
    `content` VARCHAR(191) NULL,
    `editedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`revisionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Folders` ADD CONSTRAINT `Folders_parentFolderId_fkey` FOREIGN KEY (`parentFolderId`) REFERENCES `Folders`(`folderId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Folders` ADD CONSTRAINT `Folders_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notes` ADD CONSTRAINT `Notes_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notes` ADD CONSTRAINT `Notes_folderId_fkey` FOREIGN KEY (`folderId`) REFERENCES `Folders`(`folderId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Categories` ADD CONSTRAINT `Categories_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Note_Categories` ADD CONSTRAINT `Note_Categories_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`noteId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Note_Categories` ADD CONSTRAINT `Note_Categories_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Categories`(`categoryId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attachments` ADD CONSTRAINT `Attachments_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reminders` ADD CONSTRAINT `Reminders_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Collaborators` ADD CONSTRAINT `Collaborators_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Collaborators` ADD CONSTRAINT `Collaborators_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Revision_History` ADD CONSTRAINT `Revision_History_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Notes`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;
