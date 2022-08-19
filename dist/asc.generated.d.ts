/// <reference path="./assemblyscript.generated.d.ts" />
declare module "types:assemblyscript/util/options" {
    /**
     * @fileoverview Command line options utility definitions.
     * @license Apache-2.0
     */
    /** A set of options. */
    export interface OptionSet {
        [key: string]: number | string;
    }
    /** Command line option description. */
    export interface OptionDescription {
        /** Textual description. */
        description?: string | string[];
        /** Data type. One of (b)oolean [default], (i)nteger, (f)loat or (s)tring. Uppercase means multiple values. */
        type?: "b" | "i" | "f" | "s" | "I" | "F" | "S";
        /** Substituted options, if any. */
        value?: OptionSet;
        /** Short alias, if any. */
        alias?: string;
        /** The default value, if any. */
        default?: string | number | boolean | string[] | number[];
        /** The category this option belongs in. */
        category?: string;
    }
    /** Configuration object. */
    export interface Config {
        [key: string]: OptionDescription;
    }
    /** Parsing result. */
    export interface Result {
        /** Parsed options. */
        options: OptionSet;
        /** Unknown options. */
        unknown: string[];
        /** Normal arguments. */
        arguments: string[];
        /** Trailing arguments. */
        trailing: string[];
    }
    /** Parses the specified command line arguments according to the given configuration. */
    export function parse(argv: string[], config: Config, propagateDefaults?: boolean): Result;
    /** Help formatting options. */
    export interface HelpOptions {
        /** Leading indent. Defaults to 2. */
        indent?: number;
        /** Table padding. Defaults to 24. */
        padding?: number;
        /** End of line character. Defaults to "\n". */
        eol?: string;
    }
    /** Generates the help text for the specified configuration. */
    export function help(config: Config, options?: HelpOptions): string;
    /** Merges two sets of options into one, preferring the current over the parent set. */
    export function merge(config: Config, currentOptions: OptionSet, parentOptions: OptionSet, parentBaseDir: string): OptionSet;
    /** Normalizes a path. */
    export function normalizePath(path: string): string;
    /** Resolves a single relative path. Keeps absolute paths, otherwise prepends baseDir. */
    export function resolvePath(path: string, baseDir: string, useNodeResolution?: boolean): string;
    /** Populates default values on a parsed options result. */
    export function addDefaults(config: Config, options: OptionSet): void;
}
declare module "types:assemblyscript/cli/index" {
    /**
     * @fileoverview Definitions for asc.
     * @license Apache-2.0
     */
    import { OptionDescription } from "types:assemblyscript/util/options";
    export { OptionDescription };
    /** AssemblyScript version. */
    export const version: string;
    /** Available CLI options. */
    export const options: {
        [key: string]: OptionDescription;
    };
    /** Prefix used for library files. */
    export const libraryPrefix: string;
    /** Bundled library files. */
    export const libraryFiles: {
        [key: string]: string;
    };
    /** Bundled definition files. */
    export const definitionFiles: {
        assembly: string;
        portable: string;
    };
    /** Default Binaryen optimization level. */
    export const defaultOptimizeLevel: number;
    /** Default Binaryen shrink level. */
    export const defaultShrinkLevel: number;
    /** A compatible output stream. */
    export interface OutputStream {
        /** Writes a chunk of data to the stream. */
        write(chunk: Uint8Array | string): void;
    }
    /** An in-memory output stream. */
    export interface MemoryStream extends OutputStream {
        /** Resets the stream to offset zero. */
        reset(): void;
        /** Converts the output to a buffer. */
        toBuffer(): Uint8Array;
        /** Converts the output to a string. */
        toString(): string;
    }
    /** Relevant subset of the Source class for diagnostic reporting. */
    export interface Source {
        /** Normalized path with file extension. */
        normalizedPath: string;
    }
    /** Relevant subset of the Range class for diagnostic reporting. */
    export interface Range {
        /** Start offset within the source file. */
        start: number;
        /** End offset within the source file. */
        end: number;
        /** Respective source file. */
        source: Source;
    }
    /** Relevant subset of the DiagnosticMessage class for diagnostic reporting. */
    export interface DiagnosticMessage {
        /** Message code. */
        code: number;
        /** Message category. */
        category: number;
        /** Message text. */
        message: string;
        /** Respective source range, if any. */
        range: Range | null;
        /** Related range, if any. */
        relatedRange: Range | null;
    }
    /** A function handling diagnostic messages. */
    type DiagnosticReporter = (diagnostic: DiagnosticMessage) => void;
    /** Compiler options. */
    export interface CompilerOptions {
        /** Prints just the compiler's version and exits. */
        version?: boolean;
        /** Prints the help message and exits. */
        help?: boolean;
        /** Optimizes the module. */
        optimize?: boolean;
        /** How much to focus on optimizing code. */
        optimizeLevel?: number;
        /** How much to focus on shrinking code size. */
        shrinkLevel?: number;
        /** Re-optimizes until no further improvements can be made. */
        converge?: boolean;
        /** Specifies the base directory of input and output files. */
        baseDir?: string;
        /** Specifies the WebAssembly output file (.wasm). */
        outFile?: string;
        /** Specifies the WebAssembly text output file (.wat). */
        textFile?: string;
        /** Specified the bindings to generate. */
        bindings?: string[];
        /** Enables source map generation. Optionally takes the URL. */
        sourceMap?: boolean | string;
        /** Specifies the runtime variant to include in the program. */
        runtime?: string;
        /** Disallows the use of unsafe features in user code. */
        noUnsafe?: boolean;
        /** Enables debug information in emitted binaries. */
        debug?: boolean;
        /** Replaces assertions with just their value without trapping. */
        noAssert?: boolean;
        /** Performs compilation as usual but does not emit code. */
        noEmit?: boolean;
        /** Imports the memory provided as 'env.memory'. */
        importMemory?: boolean;
        /** Does not export the memory as 'memory'. */
        noExportMemory?: boolean;
        /** Sets the initial memory size in pages. */
        initialMemory?: number;
        /** Sets the maximum memory size in pages. */
        maximumMemory?: number;
        /** Declare memory as shared. Requires maximumMemory. */
        sharedMemory?: boolean;
        /** Assume that imported memory is zero filled. Requires importMemory. */
        zeroFilledMemory?: boolean;
        /** Sets the start offset of compiler-generated static memory. */
        memoryBase?: number;
        /** Imports the function table provided as 'env.table'. */
        importTable?: boolean;
        /** Exports the function table as 'table'. */
        exportTable?: boolean;
        /** Exports the start function instead of calling it implicitly. */
        exportStart?: string;
        /** "Adds one or multiple paths to custom library components. */
        lib?: string | string[];
        /** Adds one or multiple paths to package resolution. */
        path?: string | string[];
        /** Aliases a global object under another name. */
        use?: string | string[];
        /** Sets the trap mode to use. */
        trapMode?: "allow" | "clamp" | "js";
        /** Specifies additional Binaryen passes to run. */
        runPasses?: string | string[];
        /** Skips validating the module using Binaryen. */
        noValidate?: boolean;
        /** Enables WebAssembly features that are disabled by default. */
        enable?: string | string[];
        /** Disables WebAssembly features that are enabled by default. */
        disable?: string | string[];
        /** Specifies the path to a custom transform to 'require'. */
        transform?: string | string[];
        /** Make yourself sad for no good reason. */
        pedantic?: boolean;
        /** Prints measuring information on I/O and compile times. */
        stats?: boolean;
        /** Disables terminal colors. */
        noColors?: boolean;
    }
    /** Compiler API options. */
    export interface APIOptions {
        /** Standard output stream to use. */
        stdout?: OutputStream;
        /** Standard error stream to use. */
        stderr?: OutputStream;
        /** Reads a file from disk (or memory). */
        readFile?: (filename: string, baseDir: string) => (string | null) | Promise<string | null>;
        /** Writes a file to disk (or memory). */
        writeFile?: (filename: string, contents: Uint8Array, baseDir: string) => void | Promise<void>;
        /** Lists all files within a directory. */
        listFiles?: (dirname: string, baseDir: string) => (string[] | null) | Promise<string[] | null>;
        /** Handler for diagnostic messages. */
        reportDiagnostic?: DiagnosticReporter;
        /** Additional transforms to apply. */
        transforms?: Transform[];
    }
    /** Compiler API result. */
    export interface APIResult {
        /** Encountered error, if any. */
        error: Error | null;
        /** Standard output stream. */
        stdout: OutputStream;
        /** Standard error stream.  */
        stderr: OutputStream;
        /** Statistics. */
        stats: Stats;
    }
    /** Runs the command line utility using the specified arguments array. */
    export function main(argv: string[] | CompilerOptions, options?: APIOptions): Promise<APIResult>;
    /** Convenience function that parses and compiles source strings directly. */
    export function compileString(sources: {
        [key: string]: string;
    } | string, options?: CompilerOptions): Promise<APIResult & {
        /** Emitted binary. */
        binary: Uint8Array | null;
        /** Emitted text format. */
        text: string | null;
    }>;
    /** Checks diagnostics emitted so far for errors. */
    export function checkDiagnostics(emitter: Record<string, unknown>, stderr?: OutputStream, reportDiagnostic?: DiagnosticReporter, useColors?: boolean): boolean;
    /** Statistics for the current task. */
    export class Stats {
        /** Number of files read. */
        readCount: number;
        /** Number of files written. */
        writeCount: number;
        /** Time taken to parse files. */
        parseTime: number;
        /** Number of files parsed. */
        parseCount: number;
        /** Time taken to compile programs. */
        compileTime: number;
        /** Number of programs compiled. */
        compileCount: number;
        /** Time taken to emit files. */
        emitTime: number;
        /** Number of emitted files. */
        emitCount: number;
        /** Time taken to validate modules. */
        validateTime: number;
        /** Number of modules validated. */
        validateCount: number;
        /** Time taken to optimize modules. */
        optimizeTime: number;
        /** Number of modules optimized. */
        optimizeCount: number;
        /** Begins measuring execution time. */
        begin(): number;
        /** Ends measuring execution time since `begin`. */
        end(begin: number): number;
        /** Returns a string representation. */
        toString(): string;
    }
    /** Creates a memory stream that can be used in place of stdout/stderr. */
    export function createMemoryStream(fn?: (chunk: Uint8Array | string) => void): MemoryStream;
    /** Compatible TypeScript compiler options for syntax highlighting etc. */
    export const tscOptions: Record<string, unknown>;
    import { Program, Parser, Module } from "types:assemblyscript/src/index";
    /** Compiler transform base class. */
    export abstract class Transform {
        /** Program reference. */
        readonly program: Program;
        /** Base directory. */
        readonly baseDir: string;
        /** Output stream used by the compiler. */
        readonly stdout: OutputStream;
        /** Error stream used by the compiler. */
        readonly stderr: OutputStream;
        /** Logs a message to console. */
        readonly log: typeof console.log;
        /** Reads a file from disk. */
        readFile(filename: string, baseDir: string): (string | null) | Promise<string | null>;
        /** Writes a file to disk. */
        writeFile(filename: string, contents: string | Uint8Array, baseDir: string): void | Promise<void>;
        /** Lists all files in a directory. */
        listFiles(dirname: string, baseDir: string): (string[] | null) | Promise<string[] | null>;
        /** Called when parsing is complete, before a program is instantiated from the AST. */
        afterParse?(parser: Parser): void | Promise<void>;
        /** Called after the program is instantiated. */
        afterInitialize?(program: Program): void | Promise<void>;
        /** Called when compilation is complete, before the module is being validated. */
        afterCompile?(module: Module): void | Promise<void>;
    }
}
