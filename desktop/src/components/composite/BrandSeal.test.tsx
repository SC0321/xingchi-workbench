import { render } from '@testing-library/react'
import '@testing-library/jest-dom'
import { describe, expect, it } from 'vitest'
import { BrandSeal } from './BrandSeal'

describe('BrandSeal', () => {
  it('renders the shared SFLARE logo asset at each supported size', () => {
    for (const size of ['sm', 'md', 'lg', 'xl'] as const) {
      const { container, unmount } = render(<BrandSeal size={size} />)
      const image = container.querySelector('img')!
      expect(image).toHaveAttribute('src', '/branding/sflare-logo.png')
      expect(image).toHaveAttribute('aria-hidden', 'true')
      expect(image).toHaveClass('object-contain')
      unmount()
    }
  })
})
