import { defineConfig } from 'vite';
import createReactPlugin from '@vitejs/plugin-react';
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: process.env['NODE_ENV'] === 'production' ? {
      // alias so we can use preact with react bindings :O
      react: 'preact/compat',
      'react-dom': 'preact/compat'
    } : {
      react: 'preact/compat',
      // instead of binding directly to 'preact/compat'
      // I recursively bind to 'react' (previously aliased)
      // and vite will only load 1 file instead of 2 identiqual files
      // 1 for 'react' and 1 for 'react-dom'
      // this doesnt works when building
      'react-dom': 'react'
    }
  },
  plugins: [createReactPlugin(), createReScriptPlugin()],
  test: {
    include: ['tests/**/*_test.bs.js'],
    globals: true,
    environment: 'jsdom',
    setupFiles: './tests/setup.ts',
  },
});
