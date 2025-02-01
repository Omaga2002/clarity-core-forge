import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types
} from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can register new application",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    const appName = "Test App";
    
    let block = chain.mineBlock([
      Tx.contractCall(
        "core-forge-registry",
        "register-app",
        [types.principal(deployer.address), types.ascii(appName)],
        deployer.address
      )
    ]);
    
    assertEquals(block.receipts[0].result.expectOk(), true);
  },
});

Clarinet.test({
  name: "Cannot register duplicate application",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    // Test implementation
  },
});
