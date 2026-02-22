import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '../generated/prisma/client';

@Injectable()
export class AccountsService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.AccountCreateInput) {
    return this.prisma.account.create({ data });
  }

  async findAll() {
    return this.prisma.account.findMany({
      where: { isActive: true },
      orderBy: { createdAt: 'asc' },
    });
  }

  async findOne(id: string) {
    return this.prisma.account.findUnique({ where: { id } });
  }
}
