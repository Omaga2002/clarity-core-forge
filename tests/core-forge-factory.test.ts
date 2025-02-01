import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types
} from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can create new application from authorized template",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    // Test implementation
  },
});

Clarinet.test({
  name: "Cannot create application from unauthorized template",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    // Test implementation
  },
});
