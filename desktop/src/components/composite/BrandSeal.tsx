import { BRAND } from '@/lib/brand'
import { cx } from '@/lib/cx'
import { publicAssetPath } from '@/lib/publicAsset'

/** Shared SFLARE/星炽动力 brand mark used throughout the desktop UI. */
export type BrandSealSize = 'sm' | 'md' | 'lg' | 'xl'

const SIZES: Record<BrandSealSize, string> = {
  sm: 'h-6 w-[31px]',
  md: 'h-8 w-[41px]',
  lg: 'h-[38px] w-[48px]',
  xl: 'h-20 w-[280px] max-w-full',
}

export type BrandSealProps = {
  size?: BrandSealSize
  className?: string
}

export function BrandSeal({ size = 'md', className }: BrandSealProps) {
  return (
    <img
      src={publicAssetPath(BRAND.logo)}
      alt=""
      aria-hidden="true"
      draggable={false}
      className={cx('flex-shrink-0 object-contain', SIZES[size], className)}
    />
  )
}
