import { Voucher } from "./Guru";
import { Signature } from "ethers";
import humanizeDuration from "humanize-duration";
import { Address } from "viem";
import { useScaffoldReadContract, useScaffoldWriteContract } from "~~/hooks/scaffold-eth";

type CashOutVoucherButtonProps = {
  clientAddress: Address;
  challenged: Address[];
  closed: Address[];
  voucher: Voucher;
};

export const CashOutVoucherButton = ({
  clientAddress,
  challenged,
  closed,
  voucher
}: CashOutVoucherButtonProps) => {
  const { writeContractAsync } = useScaffoldWriteContract("Streamer");

  const { data: timeLeft } = useScaffoldReadContract({
    contractName: "Streamer",
    functionName: "timeLeft",
    args: [clientAddress],
    watch: true,
  });

  const isClientChallenged = challenged.includes(clientAddress);
  const isButtonDisabled = !voucher || 
    closed.includes(clientAddress) || 
    (isClientChallenged && !timeLeft);

  const handleCashOut = async () => {
    try {
      await writeContractAsync({
        functionName: "withdrawEarnings",
        args: [{
          ...voucher,
          sig: voucher?.signature ? Signature.from(voucher.signature) as any : undefined
        }],
      });
    } catch (err) {
      console.error("Error calling withdrawEarnings function");
    }
  };

  return (
    <div className="w-full flex flex-col items-center">
      <div className="h-8 pt-2">
        {isClientChallenged && (
          timeLeft ? (
            <>
              <span>Time left:</span> {humanizeDuration(Number(timeLeft) * 1000)}
            </>
          ) : (
            <>Challenged. Cash out timed out</>
          )
        )}
      </div>
      <button
        className={`mt-3 btn btn-primary${
          isClientChallenged ? " btn-error" : ""
        }${isButtonDisabled ? " btn-disabled" : ""}`}
        disabled={isButtonDisabled}
        onClick={handleCashOut}
      >
        Cash out latest voucher
      </button>
    </div>
  );
};