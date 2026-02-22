import { IsEnum, IsOptional, IsString } from 'class-validator';
import { AssetClass } from '../../generated/prisma/client';

export class CreateAssetDto {
  @IsString()
  name: string;

  @IsOptional()
  @IsString()
  symbol?: string;

  @IsEnum(AssetClass, {
    message: `assetClass must be one of: ${Object.values(AssetClass).join(', ')}`,
  })
  assetClass: AssetClass;

  @IsOptional()
  @IsString()
  currency?: string;
}
