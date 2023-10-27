import crypto from 'crypto';

export function hashPassword(password: string) {
    const salt = crypto.randomBytes(16).toString('hex');
    const hashPassword = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');
    return { salt, hashPassword };
}

export function verifyPassword({candidatePassword, salt, hashPassword}: {candidatePassword: string, salt: string, hashPassword: string} ){
    const candidateHash = crypto.pbkdf2Sync(candidatePassword, salt, 1000, 64, 'sha512').toString('hex');
    return candidateHash === hashPassword;
}