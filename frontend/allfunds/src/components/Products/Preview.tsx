type Props = {
    name: string,
    price: string,
    description: string,
    imageUrl: string
    stock: number
    onAdd: (() => void)
}

export function Preview({ name, price, description, imageUrl, stock, onAdd }: Props) {
    return (
        <div className="grid grid-cols-product-preview grid-rows-product-preview gap-2 lg:min-w-[15vw] min-w-[40vw] max-h-[40vh] flex-1 border-[1px] border-neutral-700">
            <div className="col-span-2 flex justify-center items-center overflow-clip">
                <img className="w-full" src={imageUrl} alt={name}/>
            </div>
            <div className="col-span-2 px-2 flex justify-between items-center">
                <h4 className="text-lg">{name}</h4><p className="text-xl">{price}</p>
            </div>
            <p className="col-span-2 px-2">{description.substring(0, 147)}...</p>
            <div className="col-span-2 flex justify-between items-center">
                <span className="text-md py-1 px-2">{ stock } left</span>
                <a
                    className="cursor-pointer text-md py-1 px-2 bg-neutral-300 hover:bg-neutral-400"
                    onClick={onAdd}
                >
                    + add
                </a>
            </div>
        </div>
    )
}